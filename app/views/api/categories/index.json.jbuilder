json.array! @categories.each do |category|

  # Category Info
  json.id category.id
  json.category_name category.category_name

  # Budget Limit
  json.budget_limit category.budget_limit
  json.budget_limit_formatted category.budget_limit_formatted

  # Amount Spent
  json.amount_spent category.sum_category_transactions
  json.amount_spent_formatted category.sum_category_transactions_formatted
  json.pending_amount category.sum_category_pending_transactions

  # Progress Bar References
  json.progress category.progress_percentage
  json.progress_style category.progress_style

  # User Information
  json.user_id category.user_id
  json.user_info category.user_info # Model method

  # Hover Style References
  json.cardMouseHover ''
  json.cardMouseClick ''
  
end