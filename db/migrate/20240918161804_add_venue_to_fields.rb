class AddVenueToFields < ActiveRecord::Migration[7.1]
  def change
    add_reference :fields, :venue, null: true, foreign_key: true
  end
end
