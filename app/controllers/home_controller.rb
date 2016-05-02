class HomeController < ApplicationController

  def demo
    skip_authorization
  	gon.test = "Hello World"
  end

  def index
    skip_authorization
    if !app_user.is_signed_in?
      redirect_to "/users/sign_in"
      return
    end
  end
end