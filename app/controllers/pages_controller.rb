class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :todays_trucks, :todays_loads ]

  def todays_loads
    if user_signed_in?
      @page_name = "Почетна"
      @active_loads = Load.where(["created_at >= ? and status = ? and user_id != ?", 48.hours.ago, true, current_user.id])
      @my_trucks = Truck.where(status: true, user_id: current_user.id)
      @suggested_loads = []
      @active_loads.each do |potential_truck|
        @my_trucks.each do |my_load|
          if (my_load.pickup.distance_to(potential_truck.pickup) <= 50 ||
            my_load.pickup.region == potential_truck.pickup.region) &&
            (my_load.dropoff.distance_to(potential_truck.dropoff) <= 50 ||
             my_load.dropoff.region == potential_truck.dropoff.region) &&
            [-3,-2,-1,0,1,2,3].include?((potential_truck.loading_date - my_load.loading_date).to_i) &&
            potential_truck.length <= my_load.length &&
            potential_truck.truck_type & my_load.truck_type != []
            @suggested_loads << potential_truck unless @suggested_loads.include?(potential_truck)
          end
        end
      end
      # paginate suggested loads
      @suggested_loads = Kaminari.paginate_array(@suggested_loads).page(params[:page]).per(4)
    else
      @page_name = "Каргстер"
    end
  end

  def todays_trucks
    if user_signed_in?
      @page_name = "Почетна"
      @active_trucks = Truck.where(["created_at >= ? and status = ? and user_id != ?", 48.hours.ago, true, current_user.id])
      @my_trucks = Load.where(status: true, user_id: current_user.id)
      @suggested_trucks = []
      @active_trucks.each do |potential_load|
        @my_trucks.each do |my_truck|
          if (my_truck.pickup.distance_to(potential_load.pickup) <= 50 ||
            my_truck.pickup.region == potential_load.pickup.region) &&
            (my_truck.dropoff.distance_to(potential_load.dropoff) <= 50 ||
             my_truck.dropoff.region == potential_load.dropoff.region) &&
            [-3,-2,-1,0,1,2,3].include?((potential_load.loading_date - my_truck.loading_date).to_i) &&
            potential_load.length <= my_truck.length &&
            potential_load.truck_type & my_truck.truck_type != []
            @suggested_loads << potential_load unless @suggested_loads.include?(potential_load)
          end
        end
      end
      # paginate suggested loads
      @suggested_trucks = Kaminari.paginate_array(@suggested_trucks).page(params[:page]).per(4)
    else
      @page_name = "Каргстер"
    end
  end


  def profile
    @page_name = "Подесувања"
    @user = current_user
  end
end
