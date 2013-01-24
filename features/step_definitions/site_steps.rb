Then /^(?:|I )should (not )?see (\d+)? ?([^"]*)$/ do |not_have, count, item|
  options = {}

  unless count.nil?
    options[:count] = count
  end

  text = text_for(item)
  unless text.empty?
    options[:text] = text
  end

  not_have ||= false
  content = content_for(item)
  selector = selector_for(item)

  # Some specific additional checks
  unless content.nil?
    unless not_have
      find(selector).should have_content(content)
    else
      find(selector).should_not have_content(content)
    end
  end

  if content.nil? && not_have
    page.should_not have_css(selector, options)
  else
    page.should have_css(selector, options)
  end
end

When /^(?:|I )(?:|try to )visit (.+)$/ do |page_name|
  visit path_to(page_name)
end


