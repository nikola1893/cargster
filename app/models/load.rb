class Load < Post
  def truck_matches
    active_trucks = Truck.eager_load(:pickup, :dropoff).where(['user_id != ? AND status = ?', self.user_id, true])
    truck_matches = []
    active_trucks.each do |t|
      if (self.pickup.distance_to(t.pickup) < 50 ||
        self.pickup.overlap?(t.pickup) ||
        self.pickup.region == t.pickup.region) &&
        (self.dropoff.distance_to(t.dropoff) < 50 ||
        self.dropoff.overlap?(t.dropoff) ||
        self.dropoff.region == t.dropoff.region) &&
        [-3,-2,-1,0,1,2,3].include?((t.loading_date - self.loading_date).to_i) &&
        t.length >= self.length &&
        t.truck_type & self.truck_type != []
        truck_matches << t
      end
    end

    return truck_matches.flatten
  end
end
