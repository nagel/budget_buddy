json.array! @categories.each do |category|
  json.id category.id
  json.category_name category.category_name
  json.user_id category.user_id
  json.user_info category.user_info # Model method
end