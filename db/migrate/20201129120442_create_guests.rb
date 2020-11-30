class CreateGuests < ActiveRecord::Migration[6.0]
  def change
    create_table :guests do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.text :phone_numbers, array: true, default: []

      t.timestamps
    end
  end
end
