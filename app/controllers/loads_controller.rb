class LoadsController < ApplicationController

  def index
    @page_name = "Мои објави"
    @trucks = Load.includes(:pickup, :dropoff).where(user_id: current_user.id).order(created_at: :desc)
  end

  def new
    @page_name = "Нова објава"
    @post = Load.new
    @post.build_pickup
    @post.build_dropoff
    @post = Load.new(truck_type: params[:truck_type], length: params[:length], comment: params[:comment], pickup_attributes: {place: params[:pickup]}, dropoff_attributes: {place: params[:dropoff]})
    authorize @post
  end

  def show
    @truck = Load.find(params[:id])
    if @truck.user == current_user
      @page_name = "Мој товар"
    else
      @page_name = "Преглед на товар"
    end
    authorize @truck
  end

  def create
    @post = Load.new(truck_params)
    @post.user_id = current_user.id
    @post.status = true
    # set pickup_place to pickup place
    @post.pickup_place = @post.pickup.place
    # set dropoff_place to dropoff place
    @post.dropoff_place = @post.dropoff.place
    if @post.save
      redirect_to load_suggestions_path(@post), notice: "Објавата за товар е успешна!"
    else
      render :new
    end
    authorize @post
  end

  def edit
    @page_name = "Измени објава"
    @post = Load.find(params[:id])
    authorize @post
    # @post.build_pickup
    # @post.build_dropoff
  end

  def update
    @post = Load.find(params[:id])
    @post.update(truck_params)
    if @post.save
      redirect_to load_path(@post), notice: "Објавата е изменета"
    else
      render :new
    end
    authorize @post
  end

  def change_status
    @post = Load.find(params[:id])
    @post.update!(status: false)
    redirect_to load_path(@post), notice: "Статусот е променет"
  end

  def load_templates
    @page_name = "Брза објава"
    @trucks = Load.where(id: Load.group(:comment, :length, :pickup_place, :dropoff_place, :truck_type).select("min(id)"), user_id: current_user.id).order(created_at: :desc)
  end

  def download_load_pdf
    client = Load.find(params[:id])
    send_data generate_pdf(client),
              filename: "Cargster_Freight_#{client.id}.pdf",
              type: "application/pdf"
  end

  def load_suggestions
    @page_name = "Предлози за возило"
    @truck = Load.find(params[:id])
    @suggested_loads = @truck.truck_matches
  end


  private

  def truck_params
    params.require(:load).permit(:comment, :length, :loading_date, {truck_type: []}, pickup_attributes: [:id, :place], dropoff_attributes: [:id, :place])
  end

  def generate_pdf(client)
    Prawn::Document.new do
      indent(30) do
      text "Cargster", size: 20, style: :bold
      text "Jednostavna spedicija"
      text "www.cargster.co"
      text " "
      text "Objava za tovar", style: :bold
      text " "
      text "Objaveno od: #{client.user.email.encode}"
      text "na: #{client.created_at.strftime("%d/%m/%Y %H:%M")}"
      text " "
      text "Utovar: #{client.pickup_place.encode('UTF-8', 'binary', invalid: :replace, undef: :replace, replace: '')}"
      text "Datum utovar: #{client.loading_date.strftime("%d/%m/%Y")}"
      text " "
      text "Istovar: #{client.dropoff_place.encode('UTF-8', 'binary', invalid: :replace, undef: :replace, replace: '')}"
      text " "
      text "Tip kamion: #{client.truck_type.drop(1).join("; ").to_lat.encode('UTF-8', 'binary', invalid: :replace, undef: :replace, replace: '')}"
      text "Dolzina: #{client.length} m"
      text " "
      text "Komentar: #{client.comment.encode('UTF-8', 'binary', invalid: :replace, undef: :replace, replace: '')}"
      end
    end.render
  end

end
