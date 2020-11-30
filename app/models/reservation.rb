class Reservation < ApplicationRecord
  belongs_to :guest
  monetize :payout_price_cents, with_model_currency: :currency
  monetize :security_price_cents, with_model_currency: :currency
  monetize :total_price_cents, with_model_currency: :currency
end
