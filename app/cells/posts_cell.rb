class PostsCell < Cell::Rails

  def index
    @months = []
    i = 0
    if Post.count
      while @months.length < 12
        date = Time.now.months_ago(i)
        first = date.at_beginning_of_month
        last = date.at_end_of_month
        if Post.all(:created_at.gte => first, :created_at.lt => last).count > 0
          @months << first
        end
        i += 1
      end
    end
    
    
    render
  end

end
