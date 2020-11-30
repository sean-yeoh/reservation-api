require 'rails_helper'

RSpec.describe 'Reservation API', type: :request do
  describe 'POST /api/v1/reservations' do
    context 'payload format 1' do
      params = {
        "reservation": {
          "start_date": "2020-03-12",
          "end_date": "2020-03-16",
          "expected_payout_amount": "3800.00",
          "guest_details": {
            "localized_description": "4 guests",
            "number_of_adults": 2,
            "number_of_children": 2,
            "number_of_infants": 0
          },
          "guest_email": "wayne_woodbridge@bnb.com",
          "guest_first_name": "Wayne",
          "guest_id": 1,
          "guest_last_name": "Woodbridge",
          "guest_phone_numbers": [
            "639123456789",
            "639123456789"
          ],
          "listing_security_price_accurate": "500.00",
          "host_currency": "AUD",
          "nights": 4,
          "number_of_guests": 4,
          "status_type": "accepted",
          "total_paid_amount_accurate": "4500.00"
        }
      }

      it 'creates a reservation' do
        expect {
          post '/api/v1/reservations', params: params
        }.to change(Reservation, :count).by(1)
      end

      it 'returns a reservation json object' do
        post '/api/v1/reservations', params: params

        json = JSON.parse(response.body)

        aggregate_failures do
          expect(json['id']).to be_present
          expect(json['start_date']).to eq params[:reservation][:start_date]
          expect(json['nights']).to eq params[:reservation][:nights]
          expect(json['guests']).to eq params[:reservation][:number_of_guests]
          expect(json['adults']).to eq params[:reservation][:guest_details][:number_of_adults]
          expect(json['children']).to eq params[:reservation][:guest_details][:number_of_children]
          expect(json['infants']).to eq params[:reservation][:guest_details][:number_of_infants]
          expect(json['status']).to eq params[:reservation][:status_type]
          expect(json['currency']).to eq params[:reservation][:host_currency]
          expect(json['payout_price']).to eq params[:reservation][:expected_payout_amount].to_money.to_s
          expect(json['security_price']).to eq params[:reservation][:listing_security_price_accurate].to_money.to_s
          expect(json['total_price']).to eq params[:reservation][:total_paid_amount_accurate].to_money.to_s
        end
      end
    end

    context 'payload format 2' do
      params = {
        "start_date": "2020-03-12",
        "end_date": "2020-03-16",
        "nights": 4,
        "guests": 4,
        "adults": 2,
        "children": 2,
        "infants": 0,
        "status": "accepted",
        "guest": {
          "id": 1,
          "first_name": "Wayne",
          "last_name": "Woodbridge",
          "phone": "639123456789",
          "email": "wayne_woodbridge@bnb.com"
        },
        "currency": "AUD",
        "payout_price": "3800.00",
        "security_price": "500",
        "total_price": "4500.00"
      }

      it 'creates a reservation' do
        expect {
          post '/api/v1/reservations', params: params
        }.to change(Reservation, :count).by(1)
      end

      it 'returns a reservation json object' do
        post '/api/v1/reservations', params: params

        json = JSON.parse(response.body)

        aggregate_failures do
          expect(json['id']).to be_present
          expect(json['start_date']).to eq params[:start_date]
          expect(json['nights']).to eq params[:nights]
          expect(json['guests']).to eq params[:guests]
          expect(json['adults']).to eq params[:adults]
          expect(json['children']).to eq params[:children]
          expect(json['infants']).to eq params[:infants]
          expect(json['status']).to eq params[:status]
          expect(json['currency']).to eq params[:currency]
          expect(json['payout_price']).to eq params[:payout_price].to_money.to_s
          expect(json['security_price']).to eq params[:security_price].to_money.to_s
          expect(json['total_price']).to eq params[:total_price].to_money.to_s
        end
      end
    end
  end
end
