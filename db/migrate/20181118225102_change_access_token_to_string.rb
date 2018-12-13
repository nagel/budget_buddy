class ChangeAccessTokenToString < ActiveRecord::Migration[5.2]
  def change
    change_column :items, :item_id, :string
    change_column :items, :access_token, :string
  end
end
