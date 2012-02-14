class LinksCell < Cell::Rails

  def index
    @links = Link.all(:sort=>"created_at desc", :limit=>20)
    @query = params
    @query.delete "page"
    render
  end

end
