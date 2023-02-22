class Truck < Post
  def loading_matches
    active_loads = Load.eager_load(:pickup, :dropoff).where(['user_id != ? AND status = ?', self.user_id, true])
    l_matches = []
    active_loads.each do |l|
      if (self.pickup.distance_to(l.pickup) < 50 ||
        self.pickup.overlap?(l.pickup) ||
        self.pickup.region == l.pickup.region) &&
        (self.dropoff.distance_to(l.dropoff) < 50 ||
        self.dropoff.overlap?(l.dropoff) ||
        self.dropoff.region == l.dropoff.region) &&
        [-3,-2,-1,0,1,2,3].include?((l.loading_date - self.loading_date).to_i) &&
        l.length <= self.length &&
        # check if any truck type is in the load truck type array
        l.truck_type & self.truck_type != [""] &&
        l.truck_type & self.truck_type != [""]
        l_matches << l
      end
    end
    return l_matches.flatten
  end

end
