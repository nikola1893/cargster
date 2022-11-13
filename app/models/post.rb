class Post < ApplicationRecord
  belongs_to :user
  has_many :pickups
  has_many :dropoffs
  accepts_nested_attributes_for :pickups
  accepts_nested_attributes_for :dropoffs
  acts_as_taggable_on :tags
end
