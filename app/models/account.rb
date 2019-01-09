class Account < ApplicationRecord
  belongs_to :item
  belongs_to :user
  has_many :transactions


  def available_formatted
    return ActionController::Base.helpers.number_to_currency(self.available)
  end 

  def current_formatted
    return ActionController::Base.helpers.number_to_currency(self.current)
  end

  def subtype_formatted

    if self.subtype == "cd"
      return self.subtype.upcase
    else
      return self.subtype.titleize
    end

  end 

end
