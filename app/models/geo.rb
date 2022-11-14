class Geo < ApplicationRecord
  belongs_to :post
  # geocoded_by :place
  # after_validation :geocode, if: :will_save_change_to_place?
  def country_code
    Geocoder.search(self.place).first.country_code
  end
end
