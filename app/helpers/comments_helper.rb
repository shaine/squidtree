class MarkdownRenderer < Redcarpet::Render::HTML
  def link(link, title, alt_text)
    "<a target=\"_blank\" href=\"#{link}\">#{alt_text}</a>"
  end
  def autolink(link, link_type)
    "<a target=\"_blank\" href=\"#{link}\">#{link}</a>"
  end
end

module CommentsHelper
  def format_comment(comment)
    unless comment.is_old?
      rndr = MarkdownRenderer.new(
        :filter_html => true,
        :no_styles => true
      )
      mkdn = Redcarpet::Markdown.new rndr, {
        :autolink => true,
        :link_attributes => {
          :target => "_new"
        }
      }
      mkdn.render(comment.content.gsub("#", "\\#")).html_safe
    else
      simple_format comment.content
    end
  end
end
