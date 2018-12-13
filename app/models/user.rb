class User < ApplicationRecord

  has_secure_password
  validates :email, presence: true, uniqueness: true

  has_many :categories
  has_many :items
  has_many :accounts
  has_many :transactions
  
end
