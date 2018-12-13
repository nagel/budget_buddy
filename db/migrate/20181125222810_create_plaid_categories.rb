class CreatePlaidCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :plaid_categories do |t|
      t.string :plaid_category_API_ID
      t.string :string
      t.string :plaid_category_name
      t.integer :category_ID

      t.timestamps
    end
  end
end
