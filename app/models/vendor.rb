class Vendor < ApplicationRecord
  #belongs_to :category

  def category_info
    Category.select("category_name", "user_id", "budget_limit").where(id: self.category_id)
  end

end
