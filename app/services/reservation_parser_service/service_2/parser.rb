class ReservationParserService::Service2::Parser
  attr_accessor :permitted_params

  KEYS = %w[
    start_date
    end_date
    nights
    guests
    adults
    children
    infants
    status
    guest
    currency
    payout_price
    security_price
    total_price
  ].freeze

  GUEST_KEYS = %w[
    id
    first_name
    last_name
    phone
    email
  ].freeze

  # Sample payload
  # {
  #   "start_date": "2020-03-12",
  #   "end_date": "2020-03-16",
  #   "nights": 4,
  #   "guests": 4,
  #   "adults": 2,
  #   "children": 2,
  #   "infants": 0,
  #   "status": "accepted",
  #   "guest": {
  #     "id": 1,
  #     "first_name": "Wayne",
  #     "last_name": "Woodbridge",
  #     "phone": "639123456789",
  #     "email": "wayne_woodbridge@bnb.com"
  #   },
  #   "currency": "AUD",
  #   "payout_price": "3800.00",
  #   "security_price": "500",
  #   "total_price": "4500.00"
  # }

  def self.parseable?(params)
    KEYS.all? { |key| params.keys.include?(key) } &&
      GUEST_KEYS.all? { |key| params[:guest].keys.include?(key) }
  end

  def initialize(params)
    permitted_keys = KEYS.dup << { guest: GUEST_KEYS }
    @permitted_params = params.permit(permitted_keys)
  end

  def parse!
    guest.reservations.create(
      start_date: permitted_params[:start_date],
      end_date: permitted_params[:end_date],
      nights: permitted_params[:nights],
      adults: permitted_params[:adults],
      infants: permitted_params[:infants],
      children: permitted_params[:children],
      guests: permitted_params[:guests],
      status: permitted_params[:status],
      currency: permitted_params[:currency],
      payout_price: permitted_params[:payout_price],
      security_price: permitted_params[:security_price],
      total_price: permitted_params[:total_price]
    )
  end

  private

  def guest
    @guest ||=
      Guest.find_by(id: permitted_params[:guest][:id]) ||
      Guest.create(
        first_name: permitted_params[:guest][:first_name],
        last_name: permitted_params[:guest][:last_name],
        email: permitted_params[:guest][:email],
        phone_numbers: [permitted_params[:guest][:phone]],
      )
  end
end




