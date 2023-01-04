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

  # get the bounding box coordinates
  def bounding_box
    # return the bounding box coordinates
    result = Geocoder.search(self.place).first
    return result.boundingbox
  end

  # # check if dwo bounding boxes overlaps
  def overlap?(box)
    box1 = Geocoder.search(box.place).first.boundingbox
    box2 = self.bounding_box
    # check if the bounding boxes overlap
    if ((box1[0].between?(box2[0], box2[1]) ||
        box1[1].between?(box2[0], box2[1])) &&
        (box1[2].between?(box2[2], box2[3]) ||
        box1[3].between?(box2[2], box2[3]))) ||
        ((box2[0].between?(box1[0], box1[1]) ||
        box2[1].between?(box1[0], box1[1])) &&
        (box2[2].between?(box1[2], box1[3]) ||
        box2[3].between?(box1[2], box1[3])))
      return true
    else
      return false
    end
  end

  # get the simple place name

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
