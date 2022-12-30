class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :todays_trucks, :todays_loads ]
  def todays_loads
    if user_signed_in?
      @page_name = "Почетна"
      @my_trucks = Truck.includes(:pickup, :dropoff, :user).where(['user_id = ? AND status = ?', current_user.id, true])
      # @active_loads = Load.where(['user_id != ? AND status = ?', current_user.id, true])
      @suggested_loads = []
      # match loads with trucks
      @my_trucks.each do |t|
         @suggested_loads << t.loading_matches
      end
      @suggested_loads.flatten!
      @suggested_loads.uniq!
    else
      @page_name = "Каргстер"
    end
  end

  def todays_trucks
    if user_signed_in?
      @page_name = "Почетна"
      @my_loads = Load.includes(:pickup, :dropoff, :user).where(['user_id = ? AND status = ?', current_user.id, true])
      # @active_loads = Load.where(['user_id != ? AND status = ?', current_user.id, true])
      @suggested_trucks = []
      # match loads with trucks
      @my_loads.each do |t|
         @suggested_trucks << t.truck_matches
      end
      @suggested_trucks.flatten!
      @suggested_trucks.uniq!
    else
      @page_name = "Каргстер"
    end
  end


  def profile
    @page_name = "Подесувања"
    @user = current_user
  end
end
