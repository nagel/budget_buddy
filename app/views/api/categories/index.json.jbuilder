json.array! @categories.each do |category|
  json.id category.id
  json.category_name category.category_name
  json.budget_limit category.budget_limit
  json.budget_limit_formatted category.budget_limit_formatted
  json.amount_spent category.sum_category_transactions
  json.amount_spent_formatted category.sum_category_transactions_formatted
  json.pending_amount category.sum_category_pending_transactions
  json.progress category.progress_percentage
  json.progress_style category.progress_style
  json.user_id category.user_id
  json.user_info category.user_info # Model method
  json.cardMouseHover ''
  json.cardMouseClick ''
end