module CommentsHelper
  def format_comment(comment)
    unless comment.is_old?
      rndr = Redcarpet::Render::HTML.new(:filter_html => true, :no_styles => true)
      mkdn = Redcarpet::Markdown.new rndr
      mkdn.render(comment.content.gsub("#", "\\#")).html_safe
    else
      simple_format comment.content
    end
  end
end
