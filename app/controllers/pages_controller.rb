class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :todays_trucks, :todays_loads ]
  def todays_loads
    if user_signed_in?
      @page_name = "Почетна"
      @active_loads = Load.includes(:pickup, :dropoff, :user).where.not(user_id: current_user.id).where(status: true).last(5)
    else
      @page_name = "Каргстер"
    end
  end

  def todays_trucks
    if user_signed_in?
      @page_name = "Почетна"
      @active_trucks = Truck.includes(:pickup, :dropoff, :user).where.not(user_id: current_user.id).where(status: true).last(5)
    else
      @page_name = "Каргстер"
    end
  end


  def profile
    @page_name = "Подесувања"
    @user = current_user
  end
end
