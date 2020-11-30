class Api::V1::ReservationsController < V1Controller
  def create
    if ::ReservationParserService.new(params).call
      render json: { message: 'Reservation successfully created.' }
    else
      render json: { error: 'Unable to parse json.' }, status: 400
    end
  end
end
