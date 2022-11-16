class Geo < ApplicationRecord
  belongs_to :post
  # geocoded_by :place
  # after_validation :geocode, if: :will_save_change_to_place?
  def country
    # get the country from the place
    place = self.place.split(',').last
    place.strip
  end
end
