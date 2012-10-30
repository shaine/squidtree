class CommentsController < ApplicationController
  load_and_authorize_resource

  # GET /comments/new
  # GET /comments/new.json
  def new
    @comment = Comment.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @comment }
    end
  end

  # GET /comments/1/edit
  def edit
    @comment = Comment.find(params[:id])
    @post = @comment.post
  end

  # POST /comments
  # POST /comments.json
  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new(params[:comment])
    @comment.user = current_user
    @comment.created_at = Time.current
    if @post
      @post.comments << @comment
    end

    respond_to do |format|
      if @post && @post.save
        format.html { redirect_to blog_path(@post, anchor: @comment.anchor), notice: 'Comment was successfully created.' }
        format.json { render json: @comment, status: :created, location: @comment }
      else
        format.html { redirect_to blog_path(@post), notice: 'Comment failed to save.' }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /comments/1
  # PUT /comments/1.json
  def update
    @comment = Comment.find(params[:id])
    @post = @comment.post

    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        format.html { redirect_to blog_path(@post, anchor: @comment.anchor), notice: 'Comment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment = Comment.find(params[:id])
    @comment.post.comments.delete @comment
    @comment.post.save

    flash[:notice] = "Comment deleted."

    respond_to do |format|
      format.html { back_or_home }
      format.json { head :no_content }
    end
  end
end
