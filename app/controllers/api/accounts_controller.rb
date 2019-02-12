class Api::AccountsController < ApplicationController

  def index
    @accounts = Account.where(user_id: current_user.id)

    # When requested from the accounts page, balances will be updated from the Plaid API
    if params[:page] == "accounts"

      # Instance of client object
      client = @@client

   
      # Retrieve Access Token
      token = Item.select(:access_token).find_by(id: 14)

      puts "*" * 50
      puts token.access_token
      puts "*" * 50

      response = client.accounts.balance.get(token.access_token)

      pp response[:accounts][0]

      @accounts.each do |account|

      end 

    end 

    render "index.json.jbuilder"
  end

  def create

    # Instance of client object
    client = @@client

    # Pull real-time balance information for each account associated with the Item
    response = client.accounts.balance.get("access-development-efd5bb34-8cb2-4d60-aabf-10a5734d6841") # Write method to retrieve access token from Item model for specific user
    accounts = response[:accounts]


    # Saves each account from item to database
    accounts.each do |account|

      # Prints info from API call to terminal
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
      current_decimaml = current.to_d

      # Commits save to database
      @account = Account.new({
        account_id: account.account_id,
        account_name: account.name,
        subtype: account.subtype,
        available: available_decimal,
        current: current_decimaml,
        currency_type: account.balances[:iso_currency_code],
        item_id: 14, # somehow query this from Item model --> Item.find_by(user)
        user_id: 1 # Change to current_user.id
      })
      @account.save

    end

    render "show.json.jbuilder"

  end

  def show
    @account = Account.find_by(id: params[:id])
    render "show.json.jbuilder"
  end

  def update

    @account = Account.find_by(id: params[:id])

    @account.account_name = params[:account_name] || @account.account_name
    @account.item_id = params[:item_id] || @account.item_id
    @account.user_id = params[:user_id] || @account.user_id

    @account.save

    render "show.json.jbuilder"
  end

  def destroy
    @account = Account.find_by(id: params[:id])
    @account.destroy

    render json: {message: "Account deleted!"}
  end

end
