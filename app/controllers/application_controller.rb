class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  around_action :scope_current_account
  before_action :authenticate_user!, if: -> {current_account}

  before_action :store_location, :store_app_user
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
  def after_sign_in_path_for(resource)
    session[:previous_url] || root_path
  end
  def store_location
    # store last url - this is needed for post-login redirect to whatever the user last visited.
    return unless request.get?
    if (request.path != "/users/sign_in" &&
        request.path != "/users/sign_up" &&
        request.path != "/users/password/new" &&
        request.path != "/users/password/edit" &&
        request.path != "/users/confirmation" &&
        request.path != "/users/sign_out" &&
        !request.xhr?) # don't store ajax calls
      session[:previous_url] = request.fullpath
    end
  end
  def store_app_user
  	if request.format.html?
      gon.app_user = get_app_user
    end
  end
  

  def get_app_user
  	current_user && current_user.as_json
  end

  

  def scope_current_account
    @current_account = AccountBase.activate_shard request.subdomain
    logger.debug "aaaaa #{current_account}"
    yield
  end

  def current_account
    @current_account
  end
  helper_method :current_account
end
