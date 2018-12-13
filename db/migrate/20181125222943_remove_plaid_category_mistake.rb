class RemovePlaidCategoryMistake < ActiveRecord::Migration[5.2]
  def change
    remove_column :plaid_categories, :string, :string
  end
end
