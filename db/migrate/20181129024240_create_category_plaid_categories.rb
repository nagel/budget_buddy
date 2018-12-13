class CreateCategoryPlaidCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :category_plaid_categories do |t|
      t.integer :category_id
      t.integer :plaid_category_id

      t.timestamps
    end
  end
end
