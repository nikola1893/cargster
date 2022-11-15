class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @trucks = Truck.includes(:pickups, :dropoffs, :tags).where(status: false).order(created_at: :desc)
  end
end
