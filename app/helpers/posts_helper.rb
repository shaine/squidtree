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
    end
    
    if extra_tag_list_string.length > 0
      
    end
    
    extra_tag_list_string.html_safe
    tag_list_string.html_safe
  end

  def comment_verb(seed)
    [
      'says',
      'comments',
      'thinks',
      'believes',
      'lies',
      'relates',
      'adds',
      'affirms',
      'alleges',
      'announces',
      'asserts',
      'claims',
      'conjectures',
      'discloses',
      'implies',
      'mentions',
      'pronounces',
      'remarks',
      'responds',
      'reveals',
      'states',
      'suggests',
      'insists',
      'argues',
      'protests',
      'swears'
    ].sample(:random => Random.new(seed))
  end
end
