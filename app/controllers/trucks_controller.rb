class TrucksController < ApplicationController


  def index
    @page_name = "Мои објави"
    @trucks = Truck.includes(:pickup, :dropoff).where(user_id: current_user.id).order(created_at: :desc)
  end

  def new
    @page_name = "Нова објава"
    # repost
    # check if params are present
    @post = Truck.new
    @post.build_pickup
    @post.build_dropoff
    @post = Truck.new(truck_type: params[:truck_type], length: params[:length], comment: params[:comment], pickup_attributes: {place: params[:pickup]}, dropoff_attributes: {place: params[:dropoff]})
    authorize @post
  end

  def show
    @truck = Truck.find(params[:id])
    if @truck.user == current_user
      @page_name = "Мој камион"
    else
      @page_name = "Преглед на камион"
    end
    authorize @truck
  end

  def create
    @post = Truck.new(truck_params)
    @post.user_id = current_user.id
    @post.status = true
    if @post.save
      redirect_to trucks_path, notice: "Објавата за камион е успешна!"
    else
      render :new
    end
    authorize @post
  end

  def edit
    @page_name = "Измени објава за камион"
    @post = Truck.find(params[:id])
    authorize @post
    # @post.build_pickup
    # @post.build_dropoff
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
    redirect_to truck_path(@post), notice: "Статусот е променет"
  end

  def truck_templates
    @page_name = "Камион шаблони"
  end

  private

  def truck_params
    params.require(:truck).permit(:comment, :length, :loading_date, {truck_type: []}, pickup_attributes: [:id, :place], dropoff_attributes: [:id, :place])
  end
end
