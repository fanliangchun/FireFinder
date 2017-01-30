class AddCategoryIdToApps < ActiveRecord::Migration[5.0]
  def change
    add_column :apps, :category_id, :integer
  end
end
