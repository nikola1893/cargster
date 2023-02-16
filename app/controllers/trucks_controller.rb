class TrucksController < ApplicationController

  def new
    @page_name = "Објави возило"
    @post = Truck.new
    @post.build_pickup
    @post.build_dropoff
    @post = Truck.new(truck_type: params[:truck_type], length: params[:length], weight: params[:weight], comment: params[:comment], pickup_attributes: {place: params[:pickup]}, dropoff_attributes: {place: params[:dropoff]})
    authorize @post
  end

  def show
    @truck = Truck.find(params[:id])
    if @truck.user == current_user
      @page_name = "Мое возило"
      @suggested_loads = @truck.loading_matches
    else
      @page_name = "Преглед на возило"
    end
    authorize @truck
  end

  def index
    @page_name = "Мои огласи"
    @trucks = Truck.eager_load(:pickup, :dropoff).where(user_id: current_user.id).order(created_at: :desc).paginate(page: params[:page], per_page: 5)
  end

  def create
    @post = Truck.new(truck_params)
    @post.user_id = current_user.id
    @post.status = true
    # set pickup_place to pickup place
    @post.pickup_place = @post.pickup.place
    # set dropoff_place to dropoff place
    @post.dropoff_place = @post.dropoff.place
    if @post.save
      redirect_to truck_path(@post), notice: "Објавата за возило е успешна!"
    else
      render :new
    end
    authorize @post
  end

  def edit
    @page_name = "Измени објава"
    @post = Truck.find(params[:id])
    authorize @post
  end

  def update
    @post = Truck.find(params[:id])
    @post.update(truck_params)
    if @post.save
      redirect_to truck_path(@post), notice: "Објавата е изменета"
    else
      render :new
    end
    authorize @post
  end

  def change_status
    @post = Truck.find(params[:id])
    @post.update!(status: false)
    redirect_to trucks_path, notice: "Објавата е деактивирана"
  end

  def truck_templates
    @page_name = "Шаблони за возила"
    @trucks = Truck.includes(:pickup, :dropoff).where(id: Truck.group(:comment, :length, :weight, :pickup_place, :dropoff_place, :truck_type).select("min(id)"), user_id: current_user.id).order(created_at: :desc)
  end

  private

  def truck_params
    params.require(:truck).permit(:comment, :length, :weight, :loading_date, {truck_type: []}, pickup_attributes: [:id, :place], dropoff_attributes: [:id, :place])
  end

end
