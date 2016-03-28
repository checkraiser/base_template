class HomeController < ApplicationController
  def index
  	gon.current_account = current_account
  	gon.current_user = current_user
  end
end