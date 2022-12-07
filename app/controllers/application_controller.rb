class ApplicationController < ActionController::Base
  include Pundit::Authorization
  before_action :authenticate_user!
  after_action :verify_authorized, only: :update, unless: :skip_pundit?
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def user_not_authorized
    redirect_to root_path,
    alert: "You are not authorized to perform this action."
  end

  private

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end
end
