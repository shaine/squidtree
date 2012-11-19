module HtmlSelectorsHelpers
  def selector_for(locator)
    case locator
    when /^the page$/
      "html > body"
    when /^the login link$/
      "a[rel=login]"
    when /^the logout link$/
      "a[rel=logout]"
    when /^the search box$/
      "#site_search"
    when /^the (.*) message$/
      case $1
      when /(404|forbidden)/
        "h1 span"
      else
        ".message.notice"
      end
    when /^posts$/
      "article.post"
    when /^the view more archive months$/
      "#months_callout a"
    when /^old archive months$/
      "#months_list"
    when /^discoveries$/
      ".discovery_link"
    when /^the discoveries sidebar$/
      "#links"
    when /^recent comments$/
      "article.comment"
    when /^the View More Discoveries link$/
      "a[rel=discoveries_view_more]"
    when /^(?:the |an )?(un)?advise button$/
      ".#{$1}advise"
    when /^(pending|active|complete|read|unread)?\s?decisions?$/
      "section.stream .decision#{$1.blank? ? "" : '.'+$1}"
    else
      raise "Can't find mapping from \"#{locator}\" to a selector.\n" +
        "Now, go and add a mapping in #{__FILE__}"
    end
  end

  def text_for(message)
    case message
    when /the logout message/
      "logged out"
    when /the forbidden message/
      "403"
    when /the 404 message/
      "404"
    else
      ""
    end
  end

  def content_for(item)
    case item
    when /old archive months/
      "2004"
    end
  end
end
World(HtmlSelectorsHelpers)
