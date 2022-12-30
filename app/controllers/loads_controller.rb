class LoadsController < ApplicationController

  def index
    @page_name = "Мои објави"
    @loads = Load.includes(:pickup, :dropoff).where(user_id: current_user.id).order(created_at: :desc)
  end

  def new
    @page_name = "Објави товар"
    @post = Load.new
    @post.build_pickup
    @post.build_dropoff
    @post = Load.new(truck_type: params[:truck_type], length: params[:length], weight: params[:weight], comment: params[:comment], pickup_attributes: {place: params[:pickup]}, dropoff_attributes: {place: params[:dropoff]})
    authorize @post
  end

  def show
    @truck = Load.find(params[:id])
    if @truck.user == current_user
      @page_name = "Мој товар"
    else
      @page_name = "Преглед на товар"
    end
    @suggested_trucks = @truck.truck_matches
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
      redirect_to load_path(@post), notice: "Објавата за товар е успешна!"
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
    if current_user.posts.where(type: "Load").count != 0
      @page_name = "Брза објава"
      @trucks = Load.includes(:pickup, :dropoff).where(id: Load.group(:comment, :length, :weight, :pickup_place, :dropoff_place, :truck_type).select("min(id)"), user_id: current_user.id).order(created_at: :desc)
    else
      redirect_to new_load_path
    end
  end

  private

  def truck_params
    params.require(:load).permit(:comment, :length, :weight, :loading_date, {truck_type: []}, pickup_attributes: [:id, :place], dropoff_attributes: [:id, :place])
  end

end
