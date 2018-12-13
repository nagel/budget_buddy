json.array! @accounts.each do |account|
  json.id account.id
  json.user_id account.user_id
  json.item_id account.item_id
  json.name account.account_name
  json.subtype account.subtype
  json.currency_type account.currency_type
  json.available account.available
  json.current account.current
end