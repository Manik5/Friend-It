class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :welcome

  def welcome
  end

  def dashboard
    @flats = current_user.flats
    @made_bookings = current_user.bookings
    @received_bookings = Booking.all.select { |booking| booking.flat.user == current_user}

    @received_requests = SwapRequest.where(requested_flat: current_user.flats)
    @sent_requests = SwapRequest.where(requester_flat: current_user.flats)

  end

  def admin_dashboard
    @swap_requests = current_user.swap_requests.where
    @flats = current_user.flats
    @received_bookings = @flats.map { |flat| flat.bookings }.flatten
    # raise
    # binding.pry
    @received_requests = SwapRequest.where(requested_flat: current_user.flats, status: "pending")
    @sent_requests = SwapRequest.where(requester_flat: current_user.flats)
  end
end
