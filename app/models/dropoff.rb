class Dropoff < Geo
  geocoded_by :place
  after_validation :geocode, if: :will_save_change_to_place?
end
