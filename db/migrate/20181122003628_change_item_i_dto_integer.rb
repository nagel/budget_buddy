class ChangeItemIDtoInteger < ActiveRecord::Migration[5.2]
  def change
    change_column :accounts, :item_id, 'integer USING CAST(item_id AS integer)'
  end
end
