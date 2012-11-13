Then /^(?:|I )should see (\d+)? ?([^"]*)$/ do |count, item|
  count ||= 1
  text = text_for(item)
  page.should have_css(selector_for(item), :count => Integer(count), :text => text)
end
