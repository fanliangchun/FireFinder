class AddIsHiddenToApp < ActiveRecord::Migration[5.0]
  def change
  	add_column :apps, :is_hidden, :boolean, default: true
  end
end
