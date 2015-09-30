class FavoritesController < ApplicationController
  def create
    @tattoo = Tattoo.find(params[:tattoo_id])
    @favorite = Favorite.new(favorite_params)
    @favorite.user = current_user
    favorite = Favorite.find_by(user: current_user, tattoo: @tattoo)
    if favorite
      @favorite.destroy
    elsif @favorite.save
      flash[:notice] = "Favorite Added Successfully!"
    else
      flash[:errors] = @favorite.errors.full_messages.join(", ")
    end
  end

  def destroy
    @favorite = Favorite.find(params[:id])
    @tattoo = @favorite.tattoo
    if !signed_in?
      authenticate_user!
    elsif signed_in? && current_user == @favorite.user
      @favorite.destroy
      flash[:notice] = 'Favorite deleted successfully.'
      redirect_to tattoo_path(@tattoo)
    else
      flash[:notice] = 'You have no permission to delete this'
      redirect_to tattoo_path(@tattoo)
    end
  end

  protected

  def favorite_params
    params.require(:favorite).permit(:tattoo)
  end
end
