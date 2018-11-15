class Account < ApplicationRecord
  belongs_to :item
  belongs_to :user
  has_many :transactions
end
