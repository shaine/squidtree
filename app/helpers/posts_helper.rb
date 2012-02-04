module PostsHelper
  def tag_list(tags, length = 0)
    tag_list_string = ""
    extra_tag_list_string = ""
    tags.each do |tag|
      tag_string = "&nbsp; <a href=\"/blog/tags/#{URI.escape(tag.to_url)}/\">#{tag}</a>"
      
      if length <= 0 || strip_tags(tag_list_string + " #{tag}").strip.length < length
        tag_list_string += tag_string
      else
        extra_tag_list_string += tag_string
      end

      puts tag_list_string
    end
    
    if extra_tag_list_string.length > 0
      
    end
    
    extra_tag_list_string.html_safe
    tag_list_string.html_safe
  end
end
