class AddAdditionalColumnsToTransactionsModel < ActiveRecord::Migration[5.2]
  def change
    add_column :transactions, :transaction_id, :string
    add_column :transactions, :amount, :decimal, :precision => 8, :scale => 2
    add_column :transactions, :transaction_date, :date
    add_column :transactions, :transaction_type, :string
    add_column :transactions, :currency_type, :string
    add_column :transactions, :pending, :boolean
  end
end
