class PagesController < ApplicationController
  def home
    if user_signed_in?
      redirect_to loads_path
    else
      @page_name = "Kаргстер"
    end
  end

  def profile
    @page_name = "За мене"
    @user = current_user
  end

  def privacy
  end

  def terms
  end
end
