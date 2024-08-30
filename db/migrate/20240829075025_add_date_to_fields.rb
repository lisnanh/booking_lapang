class AddDateToFields < ActiveRecord::Migration[7.1]
  def change
    add_column :fields, :date, :datetime
  end
end
