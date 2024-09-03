class AddUserReferenceToCompetitions < ActiveRecord::Migration[7.1]
  def change
    add_reference :competitions, :user, null: false, foreign_key: true
  end
end
