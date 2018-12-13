json.array! @items.each do |item|
  json.id item.id
  json.name item.item_name
  json.item_id item.item_id
  json.access_token item.access_token
  json.user_id item.user_id # Model metho
end