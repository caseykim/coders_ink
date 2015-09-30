class AdminController < ApplicationController
  before_action :authorize_user
  
  def create
    @user = User.find(params[:user_id])
    @user.role = "admin"
    @user.save
    flash[:success] = "#{@user.username} is now an admin."
    redirect_to users_path
  end
end
