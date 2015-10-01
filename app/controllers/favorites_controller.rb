class FavoritesController < ApplicationController
  def index
    @favorites = current_user.favorites.all
    @tattoos = []
    @favorites.each do |favorite|
      @tattoos << Tattoo.find(favorite.tattoo_id)
    end
  end
end
