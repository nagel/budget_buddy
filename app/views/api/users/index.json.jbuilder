json.array! @users.each do |user|
  json.id user.id
  json.name user.name
  json.email user.email # Model method
end