class FlatsController < ApplicationController
  def index
    @flats = Flat.all
  end

  def show
    @flat = Flat.find(params[:id])
    @booking = Booking.new
  end

  def new
    @flat = Flat.new
  end

  def create
    @flat = Flat.new(flat_params)
    @flat.user = current_user
    if @flat.save
      redirect_to new_flat_recommendation_path(@flat)
    else
      render :new 
    end
  end

  def update
    set_flat
    @flat.update(flat_params)
  end

  def edit
    set_flat
  end

  def destroy
    set_flat
    authorize @flat
    @flat.destroy
  end

  private

  def set_flat
    @flat = Flat.find(params[:id])
  end

  def flat_params
    params.require(:flat).permit(:address, :swappable, :price, :description, :title, :number_of_bathrooms, :number_of_bedrooms, :number_of_beds, :number_of_guests)
  end
end

