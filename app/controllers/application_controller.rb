class ApplicationController < ActionController::Base
  include Pundit::Authorization
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  before_action :authenticate_user!
  before_action :complete_profile, only: [:show, :new, :truck_templates, :load_templates], if: :user_signed_in?
  before_action :configure_permitted_parameters, if: :devise_controller?
  after_action :verify_authorized, only: :update, unless: :skip_pundit?

  def complete_profile
    if (current_user.company.nil? || current_user.company == "") &&
      (current_user.first_name.nil? || current_user.first_name == "") &&
      (current_user.last_name.nil? || current_user.last_name == "") &&
      (current_user.coc.nil? || current_user.coc == "") &&
      (current_user.vat.nil? || current_user.vat == "") &&
      (current_user.address.nil? || current_user.address == "") &&
      (current_user.phone_number.nil? || current_user.phone_number == "")
      flash[:alert] = "Ве молиме комплетирајте го вашиот профил."
      redirect_to(edit_user_registration_path)
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :address, :last_name, :company, :coc, :vat, :phone_number])
  end

  def user_not_authorized
    redirect_to root_path,
    alert: "Не сте авторизирани за оваа акција."
  end

  private

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end
end
