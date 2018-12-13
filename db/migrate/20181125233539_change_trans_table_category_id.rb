class ChangeTransTableCategoryId < ActiveRecord::Migration[5.2]
  def change
    rename_column :transactions, :category_id, :plaid_category_id
  end
end
