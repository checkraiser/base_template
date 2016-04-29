include ActionView::Helpers::TextHelper
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include Pundit
  include Utility
  include Auth

  before_action :store_app_user
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery unless Rails.env.test?

  if Rails.env.production?
    rescue_from Exception, with: :render_500
  end
  rescue_from ActiveRecord::RecordNotFound, :with => :resource_not_found
  rescue_from ActionController::ParameterMissing, with: :parameter_missing
  rescue_from Pundit::NotAuthorizedError, with: :permission_denied

  # Enforce access right checks for individuals resources
  after_action :verify_authorized
  protected

  def after_sign_in_path_for(resource)
    after_initialization_url = session[:previous_url] || ""
    create_encoded_url(rails_root_url + "users/after_login", {after_initialization_url: after_initialization_url})
  end

  def store_app_user
    if request.format.html?
      gon.app_user = get_app_user
    end
  end

  def get_app_user
    if app_user.is_signed_in?
      user = app_user.as_json
      return user
    else
      {}
    end
  end
  def get_app_data
    @contacts = []
    app_data = {:contacts => @contacts,
                :app_environment => Rails.env}
    return app_data
  end
  def page_title(title)
    "<head><title>#{title}</title></head>".html_safe
  end
  helper_method :page_title
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

  def parameter_missing(exception)
    if !request.format.html?
      render_json_error_message "Bad Request", 400
      return
    end
    @message = exception.message
    render "error/400", :status => 400
  end

  def permission_denied(exception)

    if !request.format.html?
      render_json_error_message "Invalid access", 403
      return
    end

    if !app_user.is_signed_in?
      flash.alert = "The page you tried to access requires you to be signed in with an appropriate account. Please login to continue."
      redirect_to new_user_session_url
      return
    end

    @message = exception.message
    render "error/403", :status => 403
  end


  def error_message_for_save(resource)
    "#{pluralize(resource.errors.count, 'error')} prohibited this #{resource.model_name.human.downcase} from being saved"
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
end
