class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    if user_signed_in?
      @page_name = "Дома"
    else
      @page_name = "Каргстер"
    end
  end

  def profile
    @page_name = "Мој профил"
    @user = current_user
  end
end
