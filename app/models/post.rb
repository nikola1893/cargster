class Post < ApplicationRecord
  belongs_to :user
  has_one :pickup, class_name: "Pickup", dependent: :destroy
  has_one :dropoff, class_name: "Dropoff", dependent: :destroy
  delegate :place, to: :pickup, prefix: true, allow_nil: true
  delegate :place, to: :dropoff, prefix: true, allow_nil: true
  accepts_nested_attributes_for :pickup
  accepts_nested_attributes_for :dropoff
  validates :loading_date, :truck_type, :length, presence: true
  validates :length, numericality: { greater_than: 0, less_than: 16 }

  def ago
    # when the post was created - now
    miliseconds = (Time.now - created_at)
    # miliseconds to minutes
    minutes = miliseconds / 60
    # minutes to hours
    hours = minutes / 60
    # hours to days
    days = hours / 24
    # display minutes if less than 60 minutes
    if minutes < 60
      "Пред #{minutes.round} мин."
    # display hours if less than 24 hours
    elsif hours < 24
      "Пред #{hours.round} часа"
      # else display days
    else
      if days < 2
      return  "Вчера"
      else
      return "Пред #{days.round} дена"
      end
    end
  end

  def self.update_status_if_start_date_in_past
    where(status: true).where("loading_date < ?", Time.zone.now).update_all(status: false)
  end

end
