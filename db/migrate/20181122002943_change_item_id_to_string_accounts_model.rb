class ChangeItemIdToStringAccountsModel < ActiveRecord::Migration[5.2]
  def change
    change_column :accounts, :item_id, :string
  end
end
