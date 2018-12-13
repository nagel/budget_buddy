class RemoveUserIdFromPlaidCategories < ActiveRecord::Migration[5.2]
  def change
    remove_column :plaid_categories, :user_id
  end
end
