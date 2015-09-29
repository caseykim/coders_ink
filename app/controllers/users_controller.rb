class UsersController < ApplicationController
  before_action :authorize_user, except: [:show]

  def index
    @users = User.all.page params[:page]
  end

  def show
    @user = User.find(params[:id])
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:success] = 'User deleted successfully.'
    redirect_to users_path
  end

  def make_admin
    @user = User.find(params[:user_id])
    @user.role = "admin"
    @user.save
    flash[:success] = "#{@user.username} is now an admin."
    redirect_to users_path
  end
end
