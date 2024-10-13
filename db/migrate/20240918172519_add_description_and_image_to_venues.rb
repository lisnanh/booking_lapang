class AddDescriptionAndImageToVenues < ActiveRecord::Migration[7.1]
  def change
    add_column :venues, :description, :string
    add_column :venues, :image, :string
  end
end
