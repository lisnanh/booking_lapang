class CreateSparrings < ActiveRecord::Migration[7.1]
  def change
    create_table :sparrings do |t|
      t.references :field, null: false, foreign_key: true
      t.string :opponent_team_name
      t.string :team_home_name
      t.string :description
      t.string :status
      t.datetime :match_date
      t.integer :duration
      t.integer :price

      t.timestamps
    end
  end
end
