class BlogController < ApplicationController
  def index
    @posts = Post.sort(:created_at.desc).limit(10)
  end

  def view
  end

end
