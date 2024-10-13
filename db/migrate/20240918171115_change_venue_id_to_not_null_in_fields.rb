class ChangeVenueIdToNotNullInFields < ActiveRecord::Migration[7.1]
  def change
    change_column_null :fields, :venue_id, false
  end
end
