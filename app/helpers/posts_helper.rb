module PostsHelper
  def tag_list(tags, length = 0)
    tag_list_string = ""
    extra_tag_list_string = ""
    tags.each_with_index do |tag, i|
      if length <= 0 || strip_tags(tag_list_string + " #{tag}").strip.length < length
        tag_string = ""
        unless i == 0
          tag_string = "&nbsp; "
        end
        tag_string += link_to(tag, posts_path(:tag=>tag))
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

  def format_post(post)
    # Parse MD if post isn't HTML
    unless post.is_html?
      rndr = Redcarpet::Render::HTML.new(
        :filter_html => false,
        :no_styles => false
      )
      mkdn = Redcarpet::Markdown.new rndr, {
        :autolink => true
      }
      mkdn.render(post.content).html_safe
    # Post is HTML
    else
      post.content
    end
  end
end
