json.id reservation.id
json.start_date reservation.start_date
json.end_date reservation.end_date
json.nights reservation.nights
json.adults reservation.adults
json.infants reservation.infants
json.children reservation.children
json.guests reservation.guests
json.currency reservation.currency
json.status reservation.status
json.payout_price reservation.payout_price.to_s
json.security_price reservation.security_price.to_s
json.total_price reservation.total_price.to_s
json.created_at reservation.created_at
json.updated_at reservation.updated_at
json.guest do
  json.id reservation.guest.id
  json.first_name reservation.guest.first_name
  json.last_name reservation.guest.last_name
  json.email reservation.guest.email
  json.phone_numbers do
    json.array! reservation.guest.phone_numbers
  end
end
