class AddInstIDtoItem < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :institution_id, :string
  end
end