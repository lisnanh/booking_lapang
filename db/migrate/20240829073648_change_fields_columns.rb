class ChangeFieldsColumns < ActiveRecord::Migration[7.1]
  def change
    # Mengubah nama kolom `image_url` menjadi `image`
    rename_column :fields, :image_url, :image
    
    # Mengubah tipe data kolom `price` dari decimal menjadi integer
    change_column :fields, :price, :integer
  end
end
