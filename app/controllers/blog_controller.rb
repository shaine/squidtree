class BlogController < ApplicationController
  def index
    @posts = Post.all(:sort=>"created_at DESC", :limit=>10)
  end

  def view
  end

end
