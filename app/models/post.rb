class Post < ApplicationRecord
  belongs_to :user
  has_many :pickups
  has_many :dropoffs
  accepts_nested_attributes_for :pickups, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :dropoffs, reject_if: :all_blank, allow_destroy: true
  acts_as_taggable_on :tags

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
      "#{minutes.round} minutes ago"
    # display hours if less than 24 hours
    elsif hours < 24
      "#{hours.round} hours ago"
      # else display days
    else
      "#{days.round} days ago"
    end
  end
end
