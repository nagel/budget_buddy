class UpdateCategoryIdFieldName < ActiveRecord::Migration[5.2]
  def change
    rename_column :plaid_categories, :category_ID, :category_id
  end
end
