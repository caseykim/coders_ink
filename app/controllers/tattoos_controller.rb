class TattoosController < ApplicationController
  def index
    @tattoos = Tattoo.order(id: :desc)
  end
end
