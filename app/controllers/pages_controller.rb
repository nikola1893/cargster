class PagesController < ApplicationController
  def home
    if user_signed_in?
      @page_name = "Почетна"
      @trucks = Truck.includes(:pickup, :dropoff).where(user_id: current_user.id).order(created_at: :desc)
      @loads = Load.includes(:pickup, :dropoff).where(user_id: current_user.id).order(created_at: :desc)
    else
      @page_name = "Kаргстер"
    end
  end
  def profile
    @page_name = "Подесувања"
    @user = current_user
  end
end
