class CommentsCell < Cell::Rails
  def index
    logs = SiteActivity.all(:limit=>3, :sort=>"updated_at DESC")
    @comments = []
    
    logs.each do |log|
      @comments << log.loggable
    end
    
    render
  end
end
