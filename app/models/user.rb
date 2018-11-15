class User < ApplicationRecord
  has_many :categories
  has_many :items
  has_many :accounts
  has_many :transactions
end
