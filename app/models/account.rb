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

  def updated_at_formatted

    if self.updated_at > (DateTime.now - 1)
      return "yesterday at " + self.updated_at.strftime("%l" + ":" + "%M"  "%p")
    elsif self.updated_at > DateTime.now.beginning_of_day
      return "today at " + self.updated_at.strftime("%l" + ":" + "%M"  "%p")
    else
      return self.updated_at.strftime("%b %e %y %l" + ":" + "%M")
    end 

  end 

end
