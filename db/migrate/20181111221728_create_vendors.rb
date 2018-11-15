class CreateVendors < ActiveRecord::Migration[5.2]
  def change
    create_table :vendors do |t|
      t.string :vendor_name
      t.integer :category_id

      t.timestamps
    end
  end
end
