json.array! @transactions.each do |transaction|
  json.id transaction.id
  json.transaction_date transaction.transaction_date
  json.name transaction.name
  json.amount transaction.amount
  json.amount_formatted transaction.amount_formatted
  json.pending transaction.pending
  json.pending_formatted transaction.pending_formatted
  json.category_id transaction.category_id
  json.category_info transaction.category_name
  json.account_id transaction.account_id
  json.account_name transaction.account_name
  json.user_id transaction.user_id
end