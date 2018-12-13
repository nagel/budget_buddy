class Api::PlaidController < ApplicationController
  def accesstoken 

    # From application controller
    client = @@client

    # Converts public token to access token
    exchange_token_response = client.item.public_token.exchange(params['public_token'])
    access_token = exchange_token_response['access_token']

    # Retrieves item_id 
    item_id = exchange_token_response['item_id']

    # Prints to other terminal 
    puts "access token: #{access_token}"
    puts "item ID: #{item_id}"

    # If item exists, update access token. If not, create new item
    item = Item.find_or_create_by(item_id: item_id)
    item.access_token = access_token
    item.user_id = current_user.id
    item.save!

    # Outputs access_token and item_id as json

    # content_type :json

    # exchange_token_response.to_json

    render json: {message: "poop"}

  end 
end
