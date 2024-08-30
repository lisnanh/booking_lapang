class ChangeFieldTypeInFields < ActiveRecord::Migration[7.1]
  def up
    change_column :fields, :field_type, :string
  end

  def down
    change_column :fields, :field_type, :integer
  end
end
