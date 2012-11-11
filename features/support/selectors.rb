module HtmlSelectorsHelpers
  def selector_for(locator)
    case locator

    when /the page/
      "html > body"
    when /the login link/
      "a[rel=login]"
    when /the logout link/
      "a[rel=logout]"
    when /posts/
      "article.post"
    when /discoveries/
      "#links li"
    when /recent comments/
      "article.comment"
    when /the View More Discoveries link/
      "#links_callout"
    when /(?:the |an )?(un)?advise button/
      ".#{$1}advise"
    when /streamed decisions?/
      "section.stream .decision"
    when /activity items?/
      "section.stream .activity"
    when /(pending|active|complete|read|unread)?\s?decisions?/
      "section.stream .decision#{$1.blank? ? "" : '.'+$1}"
    else
      raise "Can't find mapping from \"#{locator}\" to a selector.\n" +
        "Now, go and add a mapping in #{__FILE__}"
    end
  end
end
World(HtmlSelectorsHelpers)
