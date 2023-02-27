class ApplicationController < ActionController::Base
  include Pundit::Authorization
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  before_action :authenticate_user!, except: [:home, :terms, :privacy]
  before_action :verify_completed_profile, only: [:show, :new, :truck_templates, :load_templates], if: :user_signed_in?
  before_action :configure_permitted_parameters, if: :devise_controller?
  after_action :verify_authorized, only: :update, unless: :skip_pundit?

  def verify_completed_profile
    if !current_user.profile_complete?
      session[:redirect_url] = request.original_url
      redirect_to edit_user_registration_path,
      alert: "Комплетирајте го вашиот профил за да продолжите."
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :phone_number])
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
