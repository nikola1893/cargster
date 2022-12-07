class LoadsController < ApplicationController

  def show
    @truck = Load.find(params[:id])
    if @truck.user == current_user
      @page_name = "Мој товар"
    else
      @page_name = "Преглед на товар"
    end
    authorize @truck
  end

  def index
    @page_name = "Мои објави"
    @trucks = Load.includes(:pickup, :dropoff).where(user_id: current_user.id).order(created_at: :desc)
  end

  def new
    @page_name = "Нова објава"
    @post = Load.new
    @post.build_pickup
    @post.build_dropoff
    authorize @post
  end

  def create
    @post = Load.new(load_params)
    @post.user_id = current_user.id
    @post.status = true
    if @post.save
      redirect_to loads_path, notice: "Објавата за товар е успешна!"
    else
      render :new
    end
    authorize @post
  end

  def edit
    @page_name = "Измени објава за товар"
    @post = Load.find(params[:id])
    authorize @post
    # @post.build_pickup
    # @post.build_dropoff
  end

  def update
    @post = Load.find(params[:id])
    @post.update(load_params)
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

  private

  def load_params
    params.require(:truck).permit(:comment, :length, :loading_date, {truck_type: []}, pickup_attributes: [:id, :place], dropoff_attributes: [:id, :place])
  end
end
