class ChangeAccountIDtoString < ActiveRecord::Migration[5.2]
  def change
    change_column :transactions, :account_id, :string
  end
end
