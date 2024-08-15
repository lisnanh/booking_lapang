class CreateFields < ActiveRecord::Migration[7.1]
  def change
    create_table :fields do |t|
      t.references :user, null: false, foreign_key: true

      t.string :name
      t.string :address 
      t.string :city
      t.string :image_url
      t.integer :field_type, default: 0, null: false

      t.decimal :price

      t.integer :capacity

      t.text :description

      t.timestamps
    end
  end
end
