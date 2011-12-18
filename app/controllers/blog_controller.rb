class BlogController < ApplicationController
  def index
    @posts = Post.all(:sort=>"created_at desc", :limit=>10)
    
    @months = []
    i = 0
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

  def view
  end

end
