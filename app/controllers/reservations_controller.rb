class ReservationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @reservations = Reservation.all
    @reservation = Reservation.new
  end

  def show
    @reservation = Reservation.find(params[:id])
  end

  def create
    @reservation = Reservation.new(reservation_params)
    if @reservation.save
      redirect_to reservations_path, notice: '予約が作成されました。'
    else
      @reservations = Reservation.all
      render "reservations/index", status: :unprocessable_entity
    end
  end

  private
  def reservation_params
    params.require(:reservation).permit(:start_time, :end_time, :instrument_id).merge(user_id: current_user.id)
  end
end
