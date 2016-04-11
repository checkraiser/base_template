class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  #include Pundit
  include Utility
  include Auth

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery unless Rails.env.test?

  if Rails.env.production?
    rescue_from Exception, with: :render_500
  end
  rescue_from ActiveRecord::RecordNotFound, :with => :resource_not_found

  # Enforce access right checks for individuals resources
#  after_filter :verify_authorized
  protected

  
end
