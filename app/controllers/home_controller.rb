class HomeController < ApplicationController

  def demo
    skip_authorization
  	gon.test = "Hello World"
  end

  def index
    skip_authorization
    if !app_user.is_signed_in?
      redirect_to new_user_session_path
      return
    end
  end
end