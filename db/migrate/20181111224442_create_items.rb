class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :item_name
      t.integer :item_id
      t.integer :access_token
      t.integer :user_id

      t.timestamps
    end
  end
end
