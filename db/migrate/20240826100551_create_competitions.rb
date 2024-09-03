class CreateCompetitions < ActiveRecord::Migration[7.1]
  def change
    create_table :competitions do |t|
      t.references :field, null: false, foreign_key: true
      t.string :name
      t.string :prize
      t.datetime :start_date
      t.datetime :end_date
      t.integer :registration_fee
      t.integer :price
      t.integer :number_of_teams
      t.text :description

      t.timestamps
    end
  end
end
