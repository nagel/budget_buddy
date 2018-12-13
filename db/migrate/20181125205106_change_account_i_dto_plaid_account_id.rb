class ChangeAccountIDtoPlaidAccountId < ActiveRecord::Migration[5.2]
  def change
    rename_column :accounts, :account_id, :account_id_plaid
    add_column :accounts, :account_id, :integer
  end
end
