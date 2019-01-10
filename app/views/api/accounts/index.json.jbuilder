json.array! @accounts.each do |account|
  json.id account.id
  json.user_id account.user_id
  json.item_id account.item_id
  json.name account.account_name
  json.subtype account.subtype
  json.subtype_formatted account.subtype_formatted
  json.currency_type account.currency_type
  json.available account.available
  json.available_formatted account.available_formatted
  json.current account.current
  json.current_formatted account.current_formatted
  json.updated_at account.updated_at
  json.updated_at_formatted account.updated_at_formatted

end