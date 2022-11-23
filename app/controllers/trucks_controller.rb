class TrucksController < ApplicationController

  def index
    # @trucks = Truck.includes(:pickups, :dropoffs).where(status: false).order(created_at: :desc)
  end

  def templates
    @trucks = Truck.where(id: Truck.group('comment, length, pickup_place, dropoff_place, truck_type').select("min(id)"), user_id: current_user.id)
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
    @truck.truck_type = truck_params[:tag_list]
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
