class Api::ItemsController < ApplicationController

  def index
    @items = Item.where(user_id: current_user.id)
    render "index.json.jbuilder"
  end

  # When an item is created, it will automatically save all the accounts and transactions (for the current month) associated with that item to the database. All Plaid categories will also be automatically saved to the user ID. 

  # Still needs current user functionality and category assignment
  def create

    client = @@client

    # CREATE ITEM
    ########################################################################################################

    # Converts public token to access token
    exchange_token_response = client.item.public_token.exchange(params['public_token'])
    access_token = exchange_token_response['access_token']

    # Retrieves item_id 
    item_id = exchange_token_response['item_id']

    # Retrieves institution_id
    response = client.item.get(access_token)
    item = response['item']
    inst_id = item['institution_id']

    # Retrieves Institution name
    response = client.institutions.get_by_id(inst_id)
    institution =  response['institution'] 
    inst_name = institution['name']

    # Prints key and token info to terminal
    puts " "
    puts " "
    puts "Public Token: " + params['public_token']
    puts "exchange_token_response: " + exchange_token_response.to_s
    puts "Access Token: " + access_token
    puts "Item ID: " + item_id
    puts "Institution ID: " + inst_id
    puts "Institution Name: " + inst_name
    puts " "
    puts " "

    # Commits item save to database
    @item = Item.new({
      item_name: inst_name,
      item_id: item_id,
      access_token: access_token,
      user_id: current_user.id,
      institution_id: inst_id
    })
    @item.save!

    ########################################################################################################

    # CREATE ACCOUNTS AFTER ITEM HAS BEEN SAVED
    ########################################################################################################

    # Pull real-time balance information for each account associated with the Item
    response = client.accounts.balance.get(access_token)
    accounts = response[:accounts]

    # Saves each account from item to database
    accounts.each do |account|

      # Prints info from API call to terminal
      puts " "
      puts " "
      puts "Account ID:" + account.account_id
      puts "Account Name:" + account.name
      puts "Account Subtype: " + account.subtype
      puts "Account Available: " + account.balances[:available].to_s
      puts "Account Balance: " + account.balances[:current].to_s
      puts "Account Currency: " + account.balances[:iso_currency_code]
      puts " "
      puts " "

      # Converts string amounts to decimal
      available = account.balances[:available].to_s
      available_decimal = available.to_d

      current = account.balances[:current].to_s
      current_decimal = current.to_d

      # Commits account save to database
      @account = Account.new({
        account_name: account.name,
        item_id: @item.id,
        user_id: current_user.id,
        account_id_plaid: account.account_id,
        subtype: account.subtype,
        available: available_decimal,
        current: current_decimal,
        currency_type: account.balances[:iso_currency_code]
      })
      @account.save!

    end 

    ########################################################################################################

    # SAVE TRANSACTION DATA FOR CURRENT MONTH
    ########################################################################################################

    #Pulls all transactions from the current month
    response = client.transactions.get(access_token, Date.today.at_beginning_of_month, Date.today.end_of_month)

    # Pulls only individual transaction info
    transactions = response.transactions

    transactions.each do |transaction|

      puts " "
      puts " "
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

      # Finds account ID from Account Model based on Plaid Account ID
      account = Account.find_by(account_id_plaid: transaction.account_id)
      account_id = account.id

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
      @transaction.save!

    end

    ########################################################################################################

    render "show.json.jbuilder"
  end

  def show

    client = @@client

    @item = Item.find_by(id: 14)

    item = @item
    puts item.id
    puts item.item_name
    puts item.item_id
    puts item.access_token
    puts item.user_id

    response = client.accounts.balance.get(item.access_token)
    accounts = response[:accounts]

    pp accounts

    render "show.json.jbuilder"
  end

  def update
    @item = Item.find_by(id: params[:id])

    @item.item_name = params[:item_name] || @item.item_name #need to pull this from somewhere
    @item.item_id = params[:item_id] || @item.item_id
    @item.access_token = params[:access_token] || @item.access_tokens
    @item.user_id = params[:user_id] || @item.user_id

    @item.save

    render "show.json.jbuilder"
  end

  def destroy # Will also need to delete accounts and associated transactions

    # Instance of client object
    client = @@client
    
    # Retrieves item user wishes to remove from database
    item_to_delete = Item.find_by(id: 11)
    puts item_to_delete.access_token

    # Removes item and access token from Plaid
    client.item.remove(item_to_delete.access_token)

    # Removes item and access token from database
    @item = item_to_delete
    @item.destroy

    render json: {message: "Item deleted!"}

  end

end 
