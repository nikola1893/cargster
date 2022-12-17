class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :todays_trucks ]

  def todays_loads
    if user_signed_in?
      @page_name = "Почетна"
      @active_loads = Load.where('created_at > ?', 24.hours.ago).where.not(user_id: current_user.id, status: false)
      @my_trucks = Truck.where(status: true, user_id: current_user.id)
      @suggested_loads = []
      @active_loads.each do |potential_load|
        @my_trucks.each do |my_truck|
          if (my_truck.pickup.distance_to(potential_load.pickup) < 100 ||
            my_truck.pickup.region == potential_load.pickup.region) &&
            (my_truck.dropoff.distance_to(potential_load.dropoff) < 100 ||
             my_truck.dropoff.region == potential_load.dropoff.region) &&
            [-3,-2,-1,0,1,2,3].include?((potential_load.loading_date - my_truck.loading_date).to_i) &&
            potential_load.length <= my_truck.length*1.05 &&
            potential_load.truck_type & my_truck.truck_type != []
            @suggested_loads << potential_load unless @suggested_loads.include?(potential_load)
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
      @active_trucks = Truck.where('created_at > ?', 24.hours.ago).where.not(user_id: current_user.id, status: false)
      @my_loads = Load.where(status: true, user_id: current_user.id)
      @suggested_trucks = []
      @active_trucks.each do |potential_truck|
        @my_loads.each do |my_load|
          if (my_load.pickup.distance_to(potential_truck.pickup) < 100 ||
            my_load.pickup.region == potential_truck.pickup.region) &&
            (my_load.dropoff.distance_to(potential_truck.dropoff) < 100 ||
             my_load.dropoff.region == potential_truck.dropoff.region) &&
            [-3,-2,-1,0,1,2,3].include?((potential_truck.loading_date - my_load.loading_date).to_i) &&
            potential_truck.length <= my_load.length*1.05 &&
            potential_truck.truck_type & my_load.truck_type != []
            @suggested_trucks << potential_truck unless @suggested_trucks.include?(potential_truck)
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
