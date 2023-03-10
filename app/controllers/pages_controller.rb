class PagesController < ApplicationController
  def home
    if user_signed_in?
      redirect_to all_loads_path
    else
      @page_name = "Kаргстер"
    end
  end

  def profile
    @page_name = "За мене"
    @user = current_user
  end

  def all_loads
    @page_name = "Денешни објави"
    @loads = Load.eager_load(:pickup, :dropoff).where(status: true).where.not(user_id: current_user.id).order(created_at: :desc).paginate(page: params[:page], per_page: 5)
  end

  def all_trucks
    @page_name = "Денешни објави"
    @trucks = Truck.eager_load(:pickup, :dropoff).where(status: true).where.not(user_id: current_user.id).order(created_at: :desc).paginate(page: params[:page], per_page: 5)
  end

  def privacy
  end

  def terms
  end
end
