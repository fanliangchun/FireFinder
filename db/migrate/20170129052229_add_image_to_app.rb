class AddImageToApp < ActiveRecord::Migration[5.0]
  def change
  	add_column :apps, :image, :string
  end
end
