Then /^(?:|I )should see (\d+)? ?([^"]*)$/ do |count, item|
  options = {}
  count ||= 1
  options[:count] = count
  text = text_for(item)
  unless text.empty?
    options[:text] = text
  end

  page.should have_css(selector_for(item), options)
end
