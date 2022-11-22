class TrucksController < ApplicationController

  def index
    # @trucks = Truck.includes(:pickups, :dropoffs).where(status: false).order(created_at: :desc)
  end

  def templates
    # @trucks = Truck.left_outer_joins(:pickup, :dropoff, :tags).select('tags, geos.place, length, comment').distinct
    # @trucks = Truck.eager_load(:pickup, :dropoff, :tags).select('pickup.place','length', 'comment').distinct.where(user_id: current_user.id)
    # trucks = Truck.where(user_id: current_user.id)
    joins = Truck.joins(:tags)
    @trucks = joins.where(id: Truck.group(:comment, :length, :pickup_place, :dropoff_place, :tag_list).select("min(id)"), user_id: current_user.id)
  end

  def new
    @truck = Truck.new
    @truck.build_pickup
    @truck.build_dropoff
  end

  def create
    @truck = Truck.new(truck_params)
    @truck.pickup_place = @truck.pickup.place
    @truck.dropoff_place = @truck.dropoff.place
    # @truck.tag_list = truck_params[:tag_list]
    @truck.user_id = current_user.id
    @truck.status = false
    @truck.save
    redirect_to root_path
  end


  private

  def truck_params
    params.require(:truck).permit(:comment, :length, :loading_date, tag_list: [], pickup_attributes: [:id, :place], dropoff_attributes: [:id, :place])
  end
end
