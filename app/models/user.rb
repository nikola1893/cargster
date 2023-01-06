class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  # acts_as_tagger
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  def profile_complete?
    self.first_name.present? &&
    self.last_name.present? &&
    self.address.present? &&
    self.phone_number.present? &&
    self.company.present? &&
    self.coc.present? &&
    self.vat.present?
  end
end
