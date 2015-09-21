class TattoosController < ApplicationController
  def index
    @tattoos = Tattoo.order(id: :desc)
  end

  def show
    @tattoo = Tattoo.find(params[:id])
  end
end
