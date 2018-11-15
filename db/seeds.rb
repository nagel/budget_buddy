# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.new({
  name: "Kevin Nagel",
  email: "kevin@email.com"
})
user.save

user = User.new({
  name: "Peter Tozzi",
  email: "peter@email.com"
})
user.save

category = Category.new({
  category_name: "Food",
  user_id: 1,
  budget_limit: 100
})
category.save!

category = Category.new({
  category_name: "Transport",
  user_id: 1,
  budget_limit: 200
})
category.save

category = Category.new({
  category_name: "Grub",
  user_id: 2,
  budget_limit: 200
})
category.save

category = Category.new({
  category_name: "Transport",
  user_id: 2,
  budget_limit: 400
})
category.save

vendor = Vendor.new({
  vendor_name: "Starbucks",
  category_id: 1
})
vendor.save!

vendor = Vendor.new({
  vendor_name: "Metra",
  category_id: 2
})
vendor.save

vendor = Vendor.new({
  vendor_name: "Starbucks",
  category_id: 3
})
vendor.save

vendor = Vendor.new({
  vendor_name: "Metra",
  category_id: 4
})
vendor.save

item = Item.new({
  item_name: "JP Morgan",
  item_id: 234235,
  access_token: 123234,
  user_id: 1
})
item.save

item = Item.new({
  item_name: "Discover Financial",
  item_id: 678567,
  access_token: 2341245,
  user_id: 1
})
item.save

account = Account.new({
  account_name: "Chase Credit Card",
  item_id: 1,
  user_id: 1
})
account.save!

account = Account.new({
  account_name: "Discover Credit Card",
  item_id: 2,
  user_id: 1
})
account.save

trans = Transaction.new({
  name: "Portillos",
  category_id: 1,
  account_id: 1,
  user_id: 1
})
trans.save!

trans = Transaction.new({
  name: "Metra",
  category_id: 2,
  account_id: 1,
  user_id: 1
})
trans.save


