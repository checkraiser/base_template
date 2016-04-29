class UserPolicy < ApplicationPolicy
  def after_login?
    app_user.is_signed_in?
  end
end