class BlogController < ApplicationController
  def index
    @posts = Post.sort(:created_at.desc).limit(10)
    puts @posts.count
  end

  def view
  end

end
