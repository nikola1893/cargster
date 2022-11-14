class TrucksController < ApplicationController

  def index
  end

  def templates
  end

  def new
    @truck = Truck.new
    @truck.pickups.build
    @truck.dropoffs.build
  end

  def create
    @truck = Truck.new(truck_params)
    @truck.user_id = current_user.id
    @truck.status = false
    @truck.save
    redirect_to root_path
  end


  private

  def truck_params
    params.require(:truck).permit(:comment, :length, :loading_date, tag_list: [], pickups_attributes: [:id, :_destroy, :place], dropoffs_attributes: [:id, :place, :_destroy])
  end
end
