class HomeController < ApplicationController
  def index
  	gon.test = "Hello World"
  end
end