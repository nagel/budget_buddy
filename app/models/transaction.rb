class Transaction < ApplicationRecord
  belongs_to :account
  belongs_to :categories, optional: true
  belongs_to :user

  def category_name
    category = Category.find_by(id: self.category_id)
    category ? category.category_name : "No category name"
  end 
  
  def amount_formatted
    ActionController::Base.helpers.number_to_currency(self.amount)
  end

  def pending_formatted
    pending = self.pending.to_s

    puts "TEST: " + pending.upcase

    return pending.upcase
  end

  def account_name
    account = Account.find_by(id: self.account_id)
    account_name = account.account_name
    return account_name
  end 

end
