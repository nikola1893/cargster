class Truck < Post

  def loading_matches
    active_loads = Load.where('created_at > ?', 48.hours.ago).where.not(user_id: self.user_id, status: false)
    matches = []

    active_loads.each do |geo|
      geo_pickup = Pickup.find_by(post_id: geo.id)
      geo_dropoff = Dropoff.find_by(post_id: geo.id)
      if (self.pickup.distance_to(geo_pickup) < 100 ||
        self.pickup.region == geo_pickup.region) &&
        (self.dropoff.distance_to(geo_dropoff) < 100 ||
        self.dropoff.region == geo_dropoff.region) &&
        [-3,-2,-1,0,1,2,3].include?((geo.loading_date - self.loading_date).to_i) &&
        geo.length <= self.length*1.05 &&
        geo.truck_type & self.truck_type != []
        matches << geo
      end
    end

    return matches
  end

end
