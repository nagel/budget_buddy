class Api::TransactionsController < ApplicationController

  def index

    @transactions = Transaction.where(user_id: current_user.id).order(transaction_date: :desc)

    render "index.json.jbuilder"

  end

  # For new transactions that are not being updated from the Plaid API
    # Assigns custom category to transaction if similar transaction already occurred 
    # Does not update transaction info if category is the same...
  def create

    client = @@client

    # Retrieves transaction response from Plaid for specific item
    access_token = Item.find_by(id: params[:id]).access_token

    puts "Access Token: " + access_token

    # "access-sandbox-9e993d3f-b330-4ed2-b0bf-c7cbdad9c85d" 
    response = client.transactions.get(access_token, Date.today.at_beginning_of_month, Date.today.end_of_month)
    transactions = response.transactions

    # Loop through transactions response. Assign custom category to new transaction if the plaid_category_API_ID already has a custom category assigned. 
    transactions.each do |transaction|

      # Queries database for any existing transaction with the same plaid_category_API_ID
      # matchings_trans_category = Transaction.find_by( ['user_id = :user_id and "plaid_category_API_ID" = :category', {user_id: current_user.id, category: transaction.category_id}])

      matchings_trans_category = Transaction.where(user_id: current_user.id).where(plaid_category_API_ID: transaction.category_id).where.not(category_id: nil)

      puts ""
      puts "-------------------------------------"
      pp matchings_trans_category
      puts "-------------------------------------"
      puts ""

      # Finds account ID from Account Model based on Plaid Account ID
      account = Account.find_by(account_id_plaid: transaction.account_id)
      account_id = account.id

      # Converts string to decimal 
      amount = transaction.amount.to_s
      amount_decimal = amount.to_d

      @transaction = Transaction.new({
        name: transaction.name,
        plaid_category_API_ID: transaction.category_id,
        account_id_plaid: transaction.account_id,
        user_id: current_user.id,
        transaction_id: transaction.transaction_id, 
        amount: amount_decimal,
        account_id: account_id,
        transaction_date: transaction.date,
        transaction_type: transaction.transaction_type,
        currency_type: transaction.iso_currency_code,
        pending: transaction.pending
      })
      if matchings_trans_category.present?
        @transaction.category_id = matchings_trans_category.first.category_id
      end
      @transaction.save!

    end 

    render "show.json.jbuilder"

  end

  def show
    @transaction = Transaction.find_by(id: params[:id])
    render "show.json.jbuilder"
  end

  def update
    @transaction = Transaction.find_by(id: params[:id])

    @transaction.name = params[:name] || @transaction.name
    @transaction.plaid_category_API_ID = params[:plaid_category_API_ID] || @transaction.plaid_category_API_ID
    @transaction.account_id_plaid = params[:account_id_plaid] || @transaction.account_id_plaid
    @transaction.user_id = params[:user_id] || @transaction.user_id
    @transaction.transaction_id = params[:transaction_id] || @transaction.transaction_id
    @transaction.amount = params[:amount] || @transaction.amount
    @transaction.transaction_date = params[:transaction_date] || @transaction.transaction_date
    @transaction.transaction_type = params[:transaction_type] || @transaction.transaction_type
    @transaction.currency_type = params[:currency_type] || @transaction.currency_type
    @transaction.pending = params[:pending] || @transaction.pending
    @transaction.account_id = params[:account_id] || @transaction.account_id
    @transaction.category_id = params[:category_id] || @transaction.category_id

    @transaction.save

    render "show.json.jbuilder"
  end 

  def destroy
    @item = Item.find_by(id: params[:id])
    @item.destroy

    render json: {message: "Transaction deleted!"}
  end
end 
