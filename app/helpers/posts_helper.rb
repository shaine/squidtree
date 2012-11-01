module PostsHelper
  def tag_list(tags, length = 0)
    tag_list_string = ""
    extra_tag_list_string = ""
    tags.each do |tag|
      if length <= 0 || strip_tags(tag_list_string + " #{tag}").strip.length < length
        tag_string = "&nbsp; " + link_to(tag, posts_path(:tag=>tag))
        tag_list_string += tag_string
      else
        tag_string = link_to(tag, posts_path(:tag=>tag)) + "<br>".html_safe
        extra_tag_list_string += tag_string
      end
    end

    unless extra_tag_list_string.empty?
      tag_list_string += " <span title=\"#{CGI::escapeHTML(extra_tag_list_string)}\">...</span>".html_safe
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
