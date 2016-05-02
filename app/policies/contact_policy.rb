class ContactPolicy < ApplicationPolicy
  def manage?
    app_user.is_signed_in? and app_user.is_admin?
  end
end