class LoadsController < ApplicationController

  def new
    @page_name = "Барај возило"
    @post = Load.new
    @post.build_pickup
    @post.build_dropoff
    @post = Load.new(truck_type: params[:truck_type], length: params[:length], weight: params[:weight], comment: params[:comment], pickup_attributes: {place: params[:pickup]}, dropoff_attributes: {place: params[:dropoff]})
    authorize @post
  end

  def show
    @truck = Load.find(params[:id])
    if @truck.user == current_user
      @page_name = "Барај возило"
      @suggested_trucks = @truck.truck_matches
    else
      @page_name = "Преглед на товар"
      if @truck.status?
        flash.now[:notice] = "Ова барање е активно"
      end
    end
    if !@truck.status?
      # alert user that post is inactive
      flash.now[:alert] = "Барањето не е активно"
    end
    authorize @truck
  end

  def index
    @page_name = "Пребарувај"
    @loads = Load.eager_load(:pickup, :dropoff).where(user_id: current_user.id).order(created_at: :desc).paginate(page: params[:page], per_page: 5)
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
      redirect_to load_path(@post), notice: "Активно барање за возило"
    else
      render :new
    end
    authorize @post
  end

  def edit
    @page_name = "Барај возило"
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
    redirect_to loads_path, notice: "Објавата е деактивирана"
  end

  def load_templates
    @page_name = "Брзо пребарување"
    @trucks = Load.includes(:pickup, :dropoff).where(id: Load.group(:comment, :length, :weight, :pickup_place, :dropoff_place, :truck_type).select("min(id)"), user_id: current_user.id).order(created_at: :desc)
  end

  private

  def truck_params
    params.require(:load).permit(:comment, :length, :weight, :loading_date, {truck_type: []}, pickup_attributes: [:id, :place], dropoff_attributes: [:id, :place])
  end

end
