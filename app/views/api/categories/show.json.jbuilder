json.id @category.id
json.category_name @category.category_name
json.budget_limit @category.budget_limit
json.budget_limit_formatted @category.budget_limit_formatted
json.amount_spent @category.sum_category_transactions
json.pending_amount @category.sum_category_pending_transactions
json.progress @category.progress_percentage
json.user_id @category.user_id
json.user_info @category.user_info # Model method