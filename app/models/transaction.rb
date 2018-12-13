class Transaction < ApplicationRecord
  belongs_to :account
  belongs_to :categories, optional: true
  belongs_to :user

  def category_name
    category = Category.find_by(id: self.category_id)
    category ? category.category_name : "No category name"
  end 
  
  def amount_formatted
    ActionController::Base.helpers.number_to_currency(self.amount)
  end 

  # def categorize_transaction

  #   # Finds the logged in user
  #   user = User.find_by(id: current_user.id)

  #   # All transactions assigned to the current user's id
  #   transactions = user.transactions

  #   transactions.first.category

  #   # Initially a transaction has no category_id
  #   # BUT it does have a plaid_category_api_id
  #   # The code should auto-categorize (fill in the appropriate category_id)
  #   # loop through the matching transactions to identify the right category

  #   # Looks for any transaction with the same plaid_category_api_id. If a transaction exists with the same plaid_category_api_id AND has a category_id already assigned, the current transaction will be given the same category_id.
  #   matching_transactions = current_user.transactions.where(plaid_category_api_id: transaction.plaid_category_api_id)
  #   matching_category_ids = []

  #   matching_transactions.each do |transaction|
  #     if transaction.category_id
  #       matching_category_ids << transaction.category_id
  #     end
  #   end

  #   # At this point, all matching_category_ids should be identical
  #   # (If not, something was miscategorized)

  #   if matching_category_ids.length > 0
  #     # Done! Autocomplete the transaction's category
  #     final_category_id = matching_category_ids[0]
  #   else
  #     # User must categorize manually!!! - pick from current_user.categories

  #     # What if they don't even have a category???
  #     # Create a new category, which means making a name and choosing from Plaid's list
  #     new_category = Category.create(name: params[:name], user_id: current_user.id)

  #       found_plaid_category = PlaidCategory.find_by(plaid_category_api_id: transaction.plaid_category_api_id)
  #       CategoryPlaidCategory.create(category_id: new_category.id, plaid_category_id: found_plaid_category_id)

  #     final_category_id = new_category.id
  #   end
  #   transaction.category_id = final_category_id
  #   transaction.save


  #   if category
  #     transaction.category_id = category.id
  #   else
  #     # this type of transaction hasn't been categorized yet
  #   end

  #   # User "drags" it into a category

  #   plaid_category = PlaidCategory.find_by()

  #   join_info = current_user.categories.category_plaid_categories

  #   join_info.find_by(plaid_category_id: plaid_category.id)
  # end 

end
