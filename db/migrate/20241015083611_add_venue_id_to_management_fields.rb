class AddVenueIdToManagementFields < ActiveRecord::Migration[7.1]
  def change
    add_reference :management_fields, :venue, foreign_key: true
  end
end
