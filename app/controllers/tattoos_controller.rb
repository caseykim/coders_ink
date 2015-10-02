class TattoosController < ApplicationController
  def index
    if params[:search]
      @tattoos = Tattoo.search(params[:search]).page params[:page]
    else
      @tattoos = Tattoo.order(id: :desc).page params[:page]
    end
    respond_to do |format|
      format.html
      format.json do
        @tattoos = Tattoo.order(id: :desc).page params[:page]
        if current_user
          admin = current_user.admin?
        end
        render json: { tattoos: @tattoos, admin: admin }
      end
    end
  end

  def show
    @tattoo = Tattoo.find(params[:id])
    @review = Review.new
    @reviews = @tattoo.reviews
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
      flash[:alert] = @tattoo.errors.full_messages.join(", ")
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
      flash[:alert] = 'You have no permission to edit this posting'
      redirect_to tattoo_path(tattoo)
    end
  end

  def update
    @tattoo = Tattoo.find(params[:id])
    if @tattoo.update_attributes(tattoo_params)
      flash[:success] = 'Tattoo successfully updated.'
      redirect_to tattoo_path(@tattoo)
    elsif !signed_in?
      authenticate_user!
    else
      flash[:alert] = @tattoo.errors.full_messages.join(", ")
      render :edit
    end
  end

  def destroy
    @tattoo = Tattoo.find(params[:id])
    if signed_in? && (current_user == @tattoo.user || current_user.admin?)
      @tattoo.destroy
      flash[:success] = 'Tattoo deleted successfully.'
      if current_user.role == "admin"
        redirect_to user_path(@tattoo.user)
      else
        redirect_to tattoos_path
      end
    elsif !signed_in?
      authenticate_user!
    else
      flash[:alert] = 'You have no permission to delete this posting'
      redirect_to tattoo_path(@tattoo)
    end
  end

  def best
    tattoos = Tattoo.all.to_a
    tattoos.sort! { |a, b| a.average_rating <=> b.average_rating }.reverse
    @top_6 = [tattoos[-1], tattoos[-2], tattoos[-3], tattoos[-4], tattoos[-5], tattoos[-6]]
  end

  def favorite
    @tattoo = Tattoo.find(params[:tattoo_id])
    @favorite = Favorite.new(user: current_user, tattoo: @tattoo)
    @favorite.user = current_user
    favorite = Favorite.find_by(user: current_user, tattoo: @tattoo)
    if favorite
      favorite.destroy
      flash[:notice] = "Tattoo removed from your favorites."
    elsif @favorite.save
      flash[:notice] = "Tattoo added to your favorites."
    else
      flash[:errors] = @favorite.errors.full_messages.join(", ")
    end
    redirect_to tattoo_path(@tattoo)
  end

  protected

  def tattoo_params
    params.require(:tattoo).permit(:title, :description, :url, :studio, :artist)
  end
end
