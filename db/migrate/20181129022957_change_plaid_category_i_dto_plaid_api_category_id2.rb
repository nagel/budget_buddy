class ChangePlaidCategoryIDtoPlaidApiCategoryId2 < ActiveRecord::Migration[5.2]
  def change
    rename_column :transactions, :plaid_category_id, :plaid_category_API_ID
  end
end
