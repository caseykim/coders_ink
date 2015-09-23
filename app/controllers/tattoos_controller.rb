class TattoosController < ApplicationController
  def index
    @tattoos = Tattoo.order(id: :desc)
  end

  def show
    @tattoo = Tattoo.find(params[:id])
  end

  def new
    if signed_in?
      @tattoo = Tattoo.new
    else
      authenticate_user!
    end
  end

  def create
    @tattoo = Tattoo.new(tattoo_params)
    @tattoo.user = current_user
    if @tattoo.save
      redirect_to tattoo_path(@tattoo)
    else
      flash[:error] = @tattoo.errors.full_messages.join(", ")
      render :new
    end
  end

  def edit
    tattoo = Tattoo.find(params[:id])
    if signed_in? && current_user == tattoo.user
      @tattoo = Tattoo.find(params[:id])
    elsif !signed_in?
      authenticate_user!
    else
      flash[:notice] = 'You have no permission to edit this posting'
      redirect_to tattoo_path(tattoo)
    end
  end

  def update
    @tattoo = Tattoo.find(params[:id])
    if @tattoo.update_attributes(tattoo_params)
      flash[:notice] = 'Tattoo successfully updated.'
      redirect_to tattoo_path(@tattoo)
    elsif !signed_in?
      authenticate_user!
    else
      flash[:error] = @tattoo.errors.full_messages.join(", ")
      render :edit
    end
  end

  def destroy
    @tattoo = Tattoo.find(params[:id])
    if signed_in? && current_user == @tattoo.user
      @tattoo.destroy
      flash[:notice] = 'Tattoo deleted successfully.'
      redirect_to tattoos_path
    elsif !signed_in?
      authenticate_user!
    else
      flash[:notice] = 'You have no permission to delete this posting'
      redirect_to tattoo_path(@tattoo)
    end
  end

  protected

  def tattoo_params
    params.require(:tattoo).permit(:title, :description, :url, :studio, :artist)
  end
end
