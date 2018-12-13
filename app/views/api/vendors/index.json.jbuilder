json.array! @vendors.each do |vendor|
  json.id vendor.id
  json.name vendor.vendor_name
  json.category_id vendor.category_id 
  json.category_info vendor.category_info # Model method
end