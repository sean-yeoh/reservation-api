class Api::V1::ReservationsController < V1Controller
  def index
    @reservations = Reservation.all.includes(:guest).order(created_at: :desc)
  end

  def create
    @reservation = ReservationParserService.new(params).call

    if @reservation
      render status: 201
    else
      render json: { error: 'Unable to parse json.' }, status: 400
    end
  end
end
