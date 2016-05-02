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
    respond_to do |format|
      format.html {}
    end
  end

  def index
    authorize :user
    users = User.all
    render json: {users: users}
  end
  def create
    @user = User.new(user_params)
    authorize @user
    save_resource @user
  end

  def update
    @user = User.find(params[:id])
    authorize @user
    update_resource @user, user_params
  end

  protected
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :role)
  end
  def get_all_users
    gon.users = User.all
  end
end