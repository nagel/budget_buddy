class AddLimitToCategories < ActiveRecord::Migration[5.2]
  def change
    add_column :categories, :budget_limit, :decimal, precision: 11, scale: 2
  end
end
