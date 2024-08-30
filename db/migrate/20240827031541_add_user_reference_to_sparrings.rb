class AddUserReferenceToSparrings < ActiveRecord::Migration[7.1]
  def change
    add_reference :sparrings, :user, null: false, foreign_key: true
  end
end
