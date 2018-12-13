class PlaidCategory < ApplicationRecord
  has_many :category_plaid_categories
  has_many :categories, through: :category_plaid_categories
end
