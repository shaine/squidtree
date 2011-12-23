module Colorable
  def day_of_year
    format = '%-j'
    self.colorable_date.strftime format
  end
  
  def color_class
    "day_#{day_of_year}"
  end
  
  def created_at_formatted
    created_at.strftime('%m.%d.%y')
  end
  
  def colorable_date
    if self.respond_to? 'created_at'
      self.created_at
    elsif self.respond_to? 'strftime'
      self
    else
      Time.new
    end
  end
end

Time.send :include, Colorable

module Sass::Script::Functions
  WINTER_COLOR = Sass::Script::Color.new(:red=>0x3e, :green=>0x68, :blue=>0xb4)
  SPRING_COLOR = Sass::Script::Color.new(:red=>0x11, :green=>0x9e, :blue=>0x62)
  SUMMER_COLOR = Sass::Script::Color.new(:red=>0xe7, :green=>0x8f, :blue=>0x19)

  WINTER_SECONDARY_COLOR = Sass::Script::Color.new(:red=>0xff, :green=>0xbe, :blue=>0x46)
  SPRING_SECONDARY_COLOR = Sass::Script::Color.new(:red=>0xe6, :green=>0x53, :blue=>0x19)
  SUMMER_SECONDARY_COLOR = Sass::Script::Color.new(:red=>0x19, :green=>0x5f, :blue=>0x95)

  SUMMER_DAY = Sass::Script::Number.new(182)
  WINTER_DAY = Sass::Script::Number.new(366)
  SPRING_DAY = Sass::Script::Number.new(91)
  FIRST_DAY = Sass::Script::Number.new(0)
  
  def day_if_nil(day)
    if day.nil?
      Sass::Script::Number.new(15)
    else
      day
    end
  end
  
  def percentage_from_day_of_year(day=nil)
    day = day_if_nil(day)
    
    assert_type day, :Number
    
    # Winter to Spring
    if day.value <= SPRING_DAY.value
      percent = (day.minus FIRST_DAY).div (SPRING_DAY.minus FIRST_DAY)
    # Spring to Summer
    elsif day.value <= SUMMER_DAY.value
      percent = (day.minus SPRING_DAY).div (SUMMER_DAY.minus SPRING_DAY)
    # Summer to Winter
    else
      percent = (day.minus SUMMER_DAY).div (WINTER_DAY.minus SUMMER_DAY)
    end
    
    percentage(percent)
  end
  
  def primary_color_from_day(day=nil)
    day = day_if_nil(day)
    
    assert_type day, :Number
    
    $percent = percentage_from_day_of_year(day)
    
    # Winter to Spring
    if day.value <= SPRING_DAY.value
      mix(SPRING_COLOR, WINTER_COLOR, $percent)
    # Spring to Summer
    elsif day.value <= SUMMER_DAY.value
      mix(SUMMER_COLOR, SPRING_COLOR, $percent)
    # Summer to Winter
    else
      mix(WINTER_COLOR, SUMMER_COLOR, $percent)
    end
  end
  
  def secondary_color_from_day(day=nil)
    day = day_if_nil(day)
    
    assert_type day, :Number
    
    $percent = percentage_from_day_of_year(day)
    
    # Winter to Spring
    if day.value <= SPRING_DAY.value
      mix(SPRING_SECONDARY_COLOR, WINTER_SECONDARY_COLOR, $percent)
    # Spring to Summer
    elsif day.value <= SUMMER_DAY.value
      mix(SUMMER_SECONDARY_COLOR, SPRING_SECONDARY_COLOR, $percent)
    # Summer to Winter
    else
      mix(WINTER_SECONDARY_COLOR, SUMMER_SECONDARY_COLOR, $percent)
    end
  end
end