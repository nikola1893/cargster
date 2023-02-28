class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  after_update :send_welcome_email, if: -> { profile_complete? && welcome_email_not_sent? }
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable, :confirmable

  def profile_complete?
    first_name.present? &&
    last_name.present? &&
    phone_number.present?
  end

  def blank_attributes?
    vat.blank? ||
    address.blank? ||
    coc.blank? ||
    company.blank?
  end

  def welcome_email_not_sent?
    if welcome_email_sent == false
      return true
    else
      return false
    end
  end

  def send_welcome_email
    UserMailer.welcome_email(self).deliver_later
    update(welcome_email_sent: true)
  end

end
