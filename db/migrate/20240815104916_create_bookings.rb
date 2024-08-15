class CreateBookings < ActiveRecord::Migration[7.1]
  def change
    create_table :bookings do |t|
      t.references :user, null: false, foreign_key: true
      t.references :field, null: false, foreign_key: true

      t.datetime :check_in_date
      t.datetime :check_out_date
      t.decimal :amount 
      t.integer :booking_status, default: 0, null: false

      t.timestamps
    end
  end
end
