class CreateReservations < ActiveRecord::Migration[6.0]
  def change
    create_table :reservations do |t|
      t.belongs_to :guest, null: false, foreign_key: true
      t.date :start_date
      t.date :end_date
      t.integer :nights, default: 0
      t.integer :adults, default: 0
      t.integer :infants, default: 0
      t.integer :children, default: 0
      t.integer :guests, default: 0
      t.string :status
      t.string :currency
      t.integer :payout_price_cents, default: 0
      t.integer :security_price_cents, default: 0
      t.integer :total_price_cents, default: 0

      t.timestamps
    end
  end
end
