module Colorable
  def day_of_year
    Colorable.format_date(colorable_date).to_i
  end

  def color_class
    Colorable.color_class(day_of_year)
  end

  def created_at_formatted(show_time=false)
    base_date = '%m.%d.%y'
    if show_time
      base_date += " %I:%M%p"
    end
    date = created_at.strftime(base_date).sub("AM", "a").sub("PM", "p")
  end

  def colorable_date
    if self.respond_to? 'created_at'
      self.created_at
    elsif self.respond_to? 'strftime'
      self
    else
      Colorable.default_date
    end
  end

  def self.day_of_year
    Colorable.default_date.day_of_year
  end

  def self.color_class(day=nil)
    day ||= Colorable.day_of_year

    "day_#{day}"
  end

  def self.format_date(date)
    format = '%-j'
    date.strftime format
  end

  private

  def self.default_date
    Time.new
  end
end

Time.send :include, Colorable
Date.send :include, Colorable

class Date
  def all_months_until to
    from = self
    from, to = to, from if from > to
    m = Date.new from.year, from.month
    result = []
    while m <= to
      result << m
      m >>= 1
    end

    result
  end
end

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
    if day.nil? || day.value == ""
      Sass::Script::Number.new(Colorable.day_of_year)
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
  declare :primary_color_from_day, :args => [:number]

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
  declare :secondary_color_from_day, :args => [:number]
end
