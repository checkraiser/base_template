class Users::RegistrationsController < Devise::RegistrationsController
  skip_after_action :verify_authorized
  prepend_before_filter :require_no_authentication, :only => :none
  include Auth
  include Utility
end
