class ClientPolicy < ApplicationPolicy
  def manage?
    app_user.is_signed_in? and app_user.is_admin?
  end

  def index?
    app_user.is_signed_in? and app_user.is_admin?
  end

  def create?
    app_user.is_signed_in? and app_user.is_admin?
  end

  def update?
    app_user.is_signed_in? and app_user.is_admin?
  end
end