class Geo < ApplicationRecord
  belongs_to :post
  has_one :user, through: :post
  # belongs_to :user, through: :post
  geocoded_by :place
  after_validation :geocode, if: :will_save_change_to_place?
  def country
    # if the coumtry name is present in the images/countries folder, return the country name
    # else return the country code
    country = self.place.split(',').last.strip
    if FileTest.exists?(Rails.root + "app/assets/images/countries/#{country}.svg")
      return country
    else
      return "un"
    end
  end

  def simple
    # if the place is a country, return the country
    # else return the city
    if self.country == self.place
      self.country
    else
      self.place.split(',').first
    end
  end

end
