class CreatePayments < ActiveRecord::Migration[7.1]
  def change
    create_table :payments do |t|
      t.references :booking, null: false, foreign_key: true

      t.datetime :payment_date
      t.decimal :amount 
      t.integer :payment_status, default: 0, null: false
      t.integer :payment_method, default: 0, null: false

      t.timestamps
    end
  end
end
