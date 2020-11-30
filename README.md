# Getting Started
```bash
$ git clone git@github.com:sean-yeoh/reservation-api.git
$ cd reservation-api
$ bundle install
$ rails db:setup
```

# How To Test Using CURL
### Start Rails Server
```bash
$ cd path-to-reservation-api/reservation-api
$ bundle exec rails server
```

### Service Payload Format 1
```bash
$ curl -0 -v -X POST http://localhost:3000/api/v1/reservations \
-H "Expect:" \
-H 'Content-Type: application/json; charset=utf-8' \
--data-binary @- << EOF
{
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
EOF
```

### Service Payload Format 2
```bash
$ curl -0 -v -X POST http://localhost:3000/api/v1/reservations \
-H "Expect:" \
-H 'Content-Type: application/json; charset=utf-8' \
--data-binary @- << EOF
{
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
EOF
```

After posting using CURL, ensure a reservation json object is returned with an id.
You can also view reservations by visting the `index` endpoint.
```bash
$ curl http://localhost:3000/api/v1/reservations
```

### How To Run Test Suite
```bash
$ cd path-to-reservation-api/reservation-api
$ bundle exec rspec spec/requests/v1/reservations_spec.rb
```
