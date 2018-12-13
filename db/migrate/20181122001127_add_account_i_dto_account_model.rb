class AddAccountIDtoAccountModel < ActiveRecord::Migration[5.2]
  def change
    add_column :accounts, :account_id, :string
  end
end
