class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.string :name
      t.integer :category_id
      t.integer :account_id
      t.integer :user_id

      t.timestamps
    end
  end
end
