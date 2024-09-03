class CreateManagementFields < ActiveRecord::Migration[7.1]
  def change
    create_table :management_fields do |t|
      t.string :name
      t.text :value
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
