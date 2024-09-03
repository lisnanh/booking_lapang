class AddBookingIdToFields < ActiveRecord::Migration[7.1]
  def change
    add_column :fields, :booking_id, :integer
  end
end
