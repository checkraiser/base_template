# default policies:
# (index, show, create, new) requires sign in
# (update, edit, destroy) requires owner if resource responds to :user symbol
# else sign in is required instead

class ApplicationPolicy
  include Auth
  attr_reader :user, :resource

  def initialize(user, resource)
    @user = user
    @resource = resource
  end

  def current_user
    return @user
  end

  def new?
    create?
  end

  def edit?
    update?
  end

  protected
  ########################################################
  # item specific methods
  ########################################################
  def is_owner?
    app_user.id == @resource.user_id
  end
end
