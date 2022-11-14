class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @trucks = Truck.includes(:pickups, :dropoffs).where(status: false)
  end
end
