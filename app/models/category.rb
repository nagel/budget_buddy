class Category < ApplicationRecord
  belongs_to :user
  has_many :vendors
  has_many :transactions

  def user_info
    # User.find_by(id: user_id)
    User.select("id, name, email").where(id: user_id)
  end

end
