module Colorable
  def day_of_year
    format = '%-j'
    if self.respond_to? 'created_at'
      self.created_at.strftime format
    else
      self.strftime format
    end
  end
  
  def color_class
    "day_#{day_of_year}"
  end
end

Time.send :include, Colorable