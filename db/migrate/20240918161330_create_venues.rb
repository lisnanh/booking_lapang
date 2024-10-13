class CreateVenues < ActiveRecord::Migration[7.1]
  def change
    create_table :venues do |t|
      t.string :name
      t.string :address
      t.string :city
      t.string :field_type
      t.integer :price 
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
