class ReservationParserService::Service1::Parser
  attr_accessor :permitted_params

  NESTED_KEYS = %w[
    start_date
    end_date
    expected_payout_amount
    guest_details
    guest_email
    guest_first_name
    guest_id
    guest_last_name
    guest_phone_numbers
    listing_security_price_accurate
    host_currency
    nights
    number_of_guests
    status_type
    total_paid_amount_accurate
  ].freeze

  GUEST_DETAILS_KEYS = %w[
    number_of_adults
    number_of_children
    number_of_infants
  ].freeze

  # Sample payload
  # {
  #   "reservation": {
  #   "start_date": "2020-03-12",
  #   "end_date": "2020-03-16",
  #   "expected_payout_amount": "3800.00",
  #   "guest_details": {
  #     "localized_description": "4 guests",
  #     "number_of_adults": 2,
  #     "number_of_children": 2,
  #     "number_of_infants": 0
  #   },
  #   "guest_email": "wayne_woodbridge@bnb.com",
  #   "guest_first_name": "Wayne",
  #   "guest_id": 1,
  #   "guest_last_name": "Woodbridge",
  #   "guest_phone_numbers": [
  #    "639123456789",
  #    "639123456789"
  #   ],
  #   "listing_security_price_accurate": "500.00",
  #   "host_currency": "AUD",
  #   "nights": 4,
  #   "number_of_guests": 4,
  #   "status_type": "accepted",
  #   "total_paid_amount_accurate": "4500.00",
  # }

  def self.parseable?(params)
    params.has_key?(:reservation) &&
      NESTED_KEYS.all? { |key| params[:reservation].keys.include?(key) } &&
      GUEST_DETAILS_KEYS.all? { |key| params[:reservation][:guest_details].keys.include?(key) }
  end

  def initialize(params)
    permitted_keys = NESTED_KEYS.dup << { guest_details: GUEST_DETAILS_KEYS }
    permitted_keys.delete(:guest_phone_numbers)
    permitted_keys << { guest_phone_numbers: [] }
    @permitted_params = params.permit(reservation: permitted_keys)
  end

  def parse!
    guest.reservations.create(
      start_date: permitted_params[:reservation][:start_date],
      end_date: permitted_params[:reservation][:end_date],
      nights: permitted_params[:reservation][:nights],
      adults: permitted_params[:reservation][:guest_details][:number_of_adults],
      infants: permitted_params[:reservation][:guest_details][:number_of_infants],
      children: permitted_params[:reservation][:guest_details][:number_of_children],
      guests: permitted_params[:reservation][:number_of_guests],
      status: permitted_params[:reservation][:status_type],
      currency: permitted_params[:reservation][:host_currency],
      payout_price: permitted_params[:reservation][:expected_payout_amount],
      security_price: permitted_params[:reservation][:listing_security_price_accurate],
      total_price: permitted_params[:reservation][:total_paid_amount_accurate]
    )
  end

  private

  def guest
    @guest ||=
      Guest.find_by(id: permitted_params[:reservation][:guest_id]) ||
      Guest.create(
        first_name: permitted_params[:reservation][:guest_first_name],
        last_name: permitted_params[:reservation][:guest_last_name],
        email: permitted_params[:reservation][:guest_email],
        phone_numbers: permitted_params[:reservation][:guest_phone_numbers],
      )
  end
end
