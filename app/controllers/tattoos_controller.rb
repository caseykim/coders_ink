class TattoosController < ApplicationController
  def index
    @tattoos = Tattoo.all
  end
end
