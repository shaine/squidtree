module BlogHelper
  def tag_list(tags, length = 0)
    tag_list_string = ""
    tags.each do |tag|
      if !length || strip_tags(tag_list_string + " #{tags}").strip.length < length
        tag_list_string += "&nbsp; <a href=\"/blog/tags/#{URI.escape(tag.to_url)}/\">#{tag}</a>"
      end
    end
    
    tag_list_string.html_safe
  end
end
