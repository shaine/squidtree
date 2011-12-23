module ApplicationHelper
  def title(page_title)
    content_for(:title) { page_title }
  end
  
  def page_title(page_title)
    content_for(:page_title) { page_title }
  end
  
  def add_style_day(day)
    @style_days ||= []
    @style_days << day unless @style_days.include? day
  end
  
  def set_page_class(class_name)
    @page_class = class_name
  end
  
  def get_page_class
    @page_class || Colorable.color_class
  end
end
