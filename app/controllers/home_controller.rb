class HomeController < ApplicationController
  def index
  	skip_authorization
  	gon.message = "Hello World 2"
  end
end