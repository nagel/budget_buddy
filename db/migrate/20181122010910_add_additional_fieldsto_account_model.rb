class AddAdditionalFieldstoAccountModel < ActiveRecord::Migration[5.2]
  def change
    add_column :accounts, :subtype, :string
    add_column :accounts, :currency_type, :string
    add_column :accounts, :available, :decimal, :precision => 8, :scale => 2
    add_column :accounts, :current, :decimal, :precision => 8, :scale => 2
  end
end
