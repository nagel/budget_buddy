class AddUserIdToPlaidCategories < ActiveRecord::Migration[5.2]
  def change
    add_column :plaid_categories, :user_id, :integer
  end
end
