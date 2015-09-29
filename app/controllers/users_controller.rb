class UsersController < ApplicationController
  before_action :authorize_user, except: [:show]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end
  def destroy
    @tattoo = Tattoo.find(params[:id])
    if signed_in? && current_user == @tattoo.user
      @tattoo.destroy
      flash[:success] = 'Tattoo deleted successfully.'
      redirect_to tattoos_path
    elsif !signed_in?
      authenticate_user!
    else
      flash[:alert] = 'You have no permission to delete this posting'
      redirect_to tattoo_path(@tattoo)
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:success] = 'User deleted successfully.'
    redirect_to users_path
  end
end
