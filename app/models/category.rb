class Category < ApplicationRecord
  belongs_to :user
  has_many :transactions
  has_many :category_plaid_categories
  has_many :plaid_categories, through: :category_plaid_categories

  def user_info
    # User.find_by(id: user_id)
    User.select("id, name, email").where(id: user_id)
  end

  def transactions
    Transaction.where(category_id: self.id)
  end 

  def budget_limit_formatted
    ActionController::Base.helpers.number_to_currency(self.budget_limit)
  end

    # Sums POSTED transactions for the current month by category
  def sum_category_transactions

    category_id = self.id
    start_date = Date.today.at_beginning_of_month
    end_date = Date.today.end_of_month
    pending = false

    categorized_transaction = Transaction.where(["category_id = :category_id AND transaction_date >= :start_date AND transaction_date <= :end_date AND pending = :pending", { category_id: category_id, start_date: start_date, end_date: end_date, pending: pending }])

    sum = 0
    categorized_transaction.each do |transaction|
      sum += transaction.amount
    end 

    return sum

  end 

  # Sums POSTED transactions for the current month by category
  def sum_category_transactions_formatted

    category_id = self.id
    start_date = Date.today.at_beginning_of_month
    end_date = Date.today.end_of_month
    pending = false

    categorized_transaction = Transaction.where(["category_id = :category_id AND transaction_date >= :start_date AND transaction_date <= :end_date AND pending = :pending", { category_id: category_id, start_date: start_date, end_date: end_date, pending: pending }])

    sum = 0
    categorized_transaction.each do |transaction|
      sum += transaction.amount
    end 

    return ActionController::Base.helpers.number_to_currency(sum)

  end 

  # Sums PENDING transactions for the current month by category
  def sum_category_pending_transactions

    category_id = self.id
    start_date = Date.today.at_beginning_of_month
    end_date = Date.today.end_of_month
    pending = true

    categorized_transaction = Transaction.where(["category_id = :category_id AND transaction_date >= :start_date AND transaction_date <= :end_date AND pending = :pending", { category_id: category_id, start_date: start_date, end_date: end_date, pending: pending }])

    sum = 0
    categorized_transaction.each do |transaction|
      sum += transaction.amount
    end 

    return ActionController::Base.helpers.number_to_currency(sum)

  end 

  def progress_percentage

    category_id = self.id
    start_date = Date.today.at_beginning_of_month
    end_date = Date.today.end_of_month
    pending = false

    categorized_transaction = Transaction.where(["category_id = :category_id AND transaction_date >= :start_date AND transaction_date <= :end_date AND pending = :pending", { category_id: category_id, start_date: start_date, end_date: end_date, pending: pending }])

    sum = 0
    categorized_transaction.each do |transaction|
      sum += transaction.amount
    end 

    progress = sum / self.budget_limit
    progress = (progress * 100)

    puts "--------------------------------------------------------"
    puts progress.round
    puts "--------------------------------------------------------"


    return progress.round
  end 

  def progress_style

    progress = self.progress_percentage
    style = ""

    if progress <= 60
      style = "bg-success"
    elsif progress > 50 and progress < 75
      style = "bg-warning"
    elsif progress >= 75
      style = "bg-danger"
    end 

    puts "--------------------------------------------------------"
    puts style
    puts "--------------------------------------------------------"

    return style

  end 

end
