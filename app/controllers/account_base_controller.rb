class AccountBaseController < ApplicationController
  around_action :scope_current_account
  before_action :authenticate_user!, if: -> {current_account}

  protected
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