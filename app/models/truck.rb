class Truck < Post

  def loading_matches
    active_loads = Load.includes(:pickup, :dropoff, :user).where(['user_id != ? AND status = ?', self.user_id, true])
    matches = []
    active_loads.each do |geo|
      # geo_pickup = Pickup.find_by(post_id: geo.id)
      # geo_dropoff = Dropoff.find_by(post_id: geo.id)
      if (self.pickup.distance_to(geo.pickup) < 100 ||
        self.pickup.region == geo.pickup.region) &&
        (self.dropoff.distance_to(geo.dropoff) < 100 ||
        self.dropoff.region == geo.dropoff.region) &&
        [-3,-2,-1,0,1,2,3].include?((geo.loading_date - self.loading_date).to_i) &&
        geo.length <= self.length &&
        geo.truck_type & self.truck_type != []
        matches << geo
      end
    end

    return matches
  end

end
