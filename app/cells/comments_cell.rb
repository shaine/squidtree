class CommentsCell < Cell::Rails
  def index
    @comment_logs = SiteActivity.all(:conditions=> {:loggable_type => 'Comment'}, :limit=>3, :sort=>"created_at DESC")
    
    render
  end
end
