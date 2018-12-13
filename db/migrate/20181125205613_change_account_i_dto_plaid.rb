class ChangeAccountIDtoPlaid < ActiveRecord::Migration[5.2]
  def change
    remove_column :accounts, :account_id, :account_id_plaid
    rename_column :transactions, :account_id, :account_id_plaid
    add_column :transactions, :account_id, :integer
  end
end
