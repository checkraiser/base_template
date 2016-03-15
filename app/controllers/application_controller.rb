class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :store_location, :store_app_user
  include Pundit
  include Utility
  include Auth

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery unless Rails.env.test?

  if Rails.env.production?
    rescue_from Exception, with: :render_500
  end
  rescue_from Pundit::NotAuthorizedError, with: :permission_denied
  rescue_from ActiveRecord::RecordNotFound, :with => :resource_not_found

  # Enforce access right checks for individuals resources
  after_filter :verify_authorized
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
  def save_resource(resource, validate = true)
    if resource.save(validate: validate)
      yield resource if block_given?
      render json: resource
    else
      render_json_error resource
    end
  end

  def update_resource(resource, params, json_options = {})
    if resource.update params
      yield resource if block_given?
      render json: resource.as_json(json_options)
    else
      render_json_error resource
    end
  end

  def update_resources(resources, params, json_options = {})
    if resources.update_all params
      resources.reload
      yield resources if block_given?
      render json: resources.as_json(json_options)
    else
      render_json_error resources
    end
  end

  def destroy_resource(resource)
    resource.destroy
    yield resource if block_given?
    render json: {message: "#{resource.model_name.human.downcase} successfully destroyed"}
  end

  def destroy_resources(resources)
    resources.destroy_all
    yield resources if block_given?
    render json: {message: "Successfully destroyed"}
  end
  def render_json_message(message)
    render json: {message: message}
  end

  def render_json_error(resource, message = nil)
    if message.blank?
      message = error_message_for_save(resource)
    end
    render json: {message: message, errors: resource.errors}, status: 400
  end

  def render_json_error_message(message, status = 400)
    render json: {message: message, errors: []}, status: status
  end

  def raise_permission_denied_exception(message = "")
    raise Pundit::NotAuthorizedError, message
  end

  def permission_denied(exception)
    if app_user.is_signed_in?
      notify_exception("INVALID_ACCESS", exception)
    end

    if !request.format.html?
      render_json_error_message "Invalid access", 403
      return
    end

    if !app_user.is_signed_in?
      flash.alert = "The page you tried to access requires you to be signed in with an appropriate account. Please login to continue."
      redirect_to new_user_session_path
      return
    end

    @message = exception.message
    render "error/403", :status => 403
  end


  def error_message_for_save(resource)
    "#{pluralize(resource.errors.count, 'error')} prohibited this #{resource.model_name.human.downcase} from being saved"
  end

  def get_app_user
  	"App User Info"
  end

  def render_500(exception)
    notify_exception("GENERAL_EXCEPTION", exception)

    if !request.format.html?
      render_json_error_message "An internal server error has occurred, our engineers have been notified and are working to resolve the issue."
      return
    end
    render "error/500", :status => 500
  end

  def notify_exception(error_type, exception)
    data = {}
    data[:error_type] = error_type
    data[:controller_action] = "#{params[:controller]}##{params[:action]}"
    data[:app_user_is_signed_in] = app_user.is_signed_in?
    data[:app_user] = app_user.to_simple_hash
    data[:exception] = exception
    data[:app_user_data] = app_user
    ExceptionNotifier.notify_exception(exception, env: request.env, data: data)
  end
end
