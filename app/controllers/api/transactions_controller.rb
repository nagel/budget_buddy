class Api::TransactionsController < ApplicationController

  def index

    @transactions = Transaction.where(user_id: current_user.id).order(transaction_date: :desc)

    render "index.json.jbuilder"

    #CATEGORY VIEW --> Assign users all category IDs and then let the user make their own custom categories. The custom categories will cover mutliple Plaid provided categories. When a user assigns a custom category to a transaction, all future transactions with the Plaid category will be assigned to that custom category

    # client = Plaid::Client.new(
    #   env: :development,
    #   client_id: '5bd7725bca639100112a4e11',
    #   secret: '7c256eddd5b2b3cc68e49070348ae3',
    #   public_key: '7a7b2dccb03c34134f5e2b97c28d5d'
    # )

    # # Pulls all category info from Plaid
    # all_categories = client.categories.get()
    # api_categories = all_categories.categories

    # # Saves Plaid categories to database for user to assign custom categories to
    # api_categories.each do |api_category|

    #   @plaid_category = PlaidCategory.new({
    #     plaid_category_API_ID: api_category.category_id,
    #     plaid_category_name: api_category.hierarchy.join("-"),
    #   })
    #   @plaid_category.save

    # end



  end

  # Currently handled by item create
  def create #call from API to populate

    client = @@client

    # Pull transactions for a date range
    # response = client.transactions.get('access-development-b5e0a275-a8a9-45bb-877d-662ede64c192',
    #                                     '2018-01-01',
    #                                     '2018-02-01')

    # Manipulate the count and offset parameters to paginate
    # transactions and retrieve all available data
    response = client.transactions.get("access-development-b5e0a275-a8a9-45bb-877d-662ede64c192",
                                        Date.today.at_beginning_of_month,
                                        Date.today.end_of_month)
                                        # count: 250,
                                        # offset: 0)

    # Pulls only individual transaction info
    transactions = response.transactions

    # pp transactions

    transactions.each do |transaction|

      puts "Transaction ID: " + transaction.transaction_id
      puts "Account ID: " + transaction.account_id
      puts "Category ID: " + transaction.category_id
      puts "User ID: " + "use current_user.id here"
      puts "Name: " + transaction.name
      puts "Amount: " + transaction.amount.to_s
      puts "Date: " + transaction.date
      puts "Type: " + transaction.transaction_type
      puts "Currency Type: " + transaction.iso_currency_code
      puts "Pending: " + transaction.pending.to_s
      puts ""
      puts ""

      # Converts string to decimal 
      amount = transaction.amount.to_s
      amount_decimal = amount.to_d

      @transaction = Transaction.new({
        transaction_id: transaction.transaction_id,
        account_id_plaid: transaction.account_id,
        account_id: 1, #use Active record query based on the plaid account ID
        category_id: 1, #transaction.category_id, #use Active record query based on the plaid account ID
        user_id: 1, #replace with current_user.id 
        name: transaction.name,
        amount: amount_decimal,
        transaction_date: transaction.date,
        transaction_type: transaction.transaction_type,
        currency_type: transaction.iso_currency_code,
        pending: transaction.pending
      })
      @transaction.save!

    end

    # {"account_id"=>"9BpjXdokJYTVw7Vza07JIykONOJvBXhdZPJxn",
    # "amount"=>718.2,
    # "category"=>["Transfer", "Third Party", "Chase QuickPay"],
    # "category_id"=>"21010007",
    # "date"=>"2018-01-31",
    # "iso_currency_code"=>"USD",
    # "location"=>{},
    # "name"=>"QuickPay with Zelle payment to Chris Sanchez 6865180886",
    # "payment_meta"=>{},
    # "pending"=>false,
    # "transaction_id"=>"RNz1XmxpbaSagNav8zNkigDYZav9NVuyjVyAb",
    # "transaction_type"=>"special"}

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
