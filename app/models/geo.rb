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
    box1 = box.bounding_box
    box2 = self.bounding_box
    # > ["47.2701114", "50.5647142", "8.9763654", "13.8396495"]
    #  Bavaria
    x1 = box1[0].to_f.round(2)
    x2 = box1[1].to_f.round(2)

    x3 = box2[0].to_f.round(2)
    x4 = box2[1].to_f.round(2)
    # => ["48.0616244", "48.2481162", "11.360777", "11.7229099"]
    # Munich
    y1 = box1[2].to_f.round(2)
    y2 = box1[3].to_f.round(2)

    y3 = box2[2].to_f.round(2)
    y4 = box2[3].to_f.round(2)
    # check if the boxes overlap
    if (x1.between?(x3, x4) ||
        x2.between?(x3, x4) ||
        x3.between?(x1, x2) ||
        x4.between?(x1, x2)) &&
        (y1.between?(y3, y4) ||
        y2.between?(y3, y4) ||
        y3.between?(y1, y2) ||
        y4.between?(y1, y2))
      return true
    else
      return false
    end

    # if (x1 <= x4 && x2 >= x3) && (y1 <= y4 && y2 >= y3)
    #   return true
    # else
    #   return false
    # end

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
