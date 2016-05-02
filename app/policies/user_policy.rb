class UserPolicy < ApplicationPolicy
  def after_login?
    app_user.is_signed_in?
  end

  def manage?
    app_user.is_signed_in? and app_user.is_admin?
  end
end