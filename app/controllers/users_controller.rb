class UsersController < ApplicationController
  def after_login
    authorize :user
    app_data = get_app_data

    respond_to do |format|
      format.html {
        gon.app_data = app_data
        gon.after_initialization_url = params[:after_initialization_url]
      }
      format.json {
        render json: {
            app_data: app_data
        }
      }
    end
  end

  def manage
    authorize :user
    get_all_users
  end

  protected
  def get_all_users
    gon.users = User.all
  end
end