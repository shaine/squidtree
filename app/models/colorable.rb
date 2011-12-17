module Colorable  
  def day_of_year
    self.created_at.strftime('%-j')
  end  
end