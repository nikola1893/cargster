class Geo < ApplicationRecord
  belongs_to :post
  has_one :user, through: :post
  geocoded_by :place
  after_validation :geocode, if: :will_save_change_to_place?
  validates :place, presence: true

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

  # get region from a geo object
  def region
    # return the administrative area level 1
    # if the region is not present, return the country
    result = Geocoder.search(self.place).first
    if !result.state.nil?
      return result.state
    elsif !result.county.nil?
      return result.county
    else
      return result.country
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
