class PostsCell < Cell::Rails
  def index
    @months = Post.first(:sort=>"created_at ASC").created_at.to_date.all_months_until Post.first(:sort=>"created_at DESC").created_at.to_date
    @months.find_all{|item|
      count = Post.count(
        :created_at => {
          '$lt' => (item >> 1).midnight,
          '$gt' => item.midnight
        }
      )
    }
    @months.reverse!
    
    render
  end
end
