class PagesController < ApplicationController
  def home
    if user_signed_in?
      @page_name = "Почетна"
      posts = Post.eager_load(:pickup, :dropoff).where(user_id: current_user.id).order(created_at: :desc)
      # @trucks = Truck.eager_load(:pickup, :dropoff).where(user_id: current_user.id).order(created_at: :desc)
      # @loads = Load.includes(:pickup, :dropoff).where(user_id: current_user.id).order(created_at: :desc)
      @trucks = posts.where(type: "Truck").paginate(page: params[:page], per_page: 5)
      @loads = posts.where(type: "Load").paginate(page: params[:page], per_page: 5)
    else
      @page_name = "Kаргстер"
    end
  end
  def profile
    @page_name = "Подесувања"
    @user = current_user
  end

  def privacy
  end

  def terms
  end
end
