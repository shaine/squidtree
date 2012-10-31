class PostsController < ApplicationController
  load_and_authorize_resource :except => [:index, :show]

  # GET /posts
  # GET /posts.json
  def index
    options = {
      :page => params[:page],
      :per_page => 10,
      :order => 'created_at DESC'
    }

    if params[:month]
      month_param = params[:month]

      month = Date.parse month_param

      @outer_title = month_param

      options[:created_at] = {
        '$lt' => (month >> 1).midnight,
        '$gt' => month.midnight
      }
    elsif params[:tag]
      tag = params[:tag].downcase

      @outer_title = tag

      options[:tags] = tag
    elsif params[:user]
      user = User.find_by_slug(params[:user])

      @outer_title = user.name

      options[:user_id] = user.id
    elsif params[:search]
      search = params[:search]

      @outer_title = search

      regex = Regexp.new(Regexp.escape(search), Regexp::IGNORECASE)
      options["$or"] = [
        {:content => regex},
        {:title => regex}
      ]
    elsif params[:page]
      @outer_title = "Page #{params[:page]}"
    end

    @posts = Post.paginate(options)

    if @posts.length > 0
      @color_date = @posts.first.day_of_year

      if @posts.first.is_old? and
      flash[:notice].nil? and
      can? :read, @posts.first
        flash.now[:notice] = "You are currently viewing really, really old posts. Please forgive any broken images, links, or styles, as well as any weirdness or immaturity."
      end
    end

    @query = params
    @query.delete "page"

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.first(:slug=>params[:id])
    @comment = Comment.new

    if @post.is_old? and
    flash[:notice].nil? and
    can? :read, @post
      flash.now[:notice] = "You are currently viewing a really, really old post. Please forgive any broken images, links, or styles, as well as any weirdness or immaturity."
    end

    @color_date = @post.day_of_year

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    @post = Post.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find_by_slug(params[:id])
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(params[:post])
    @post.user = current_user

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render json: @post, status: :created, location: @post }
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    @post = Post.find_by_slug(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find_by_slug(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :ok }
    end
  end

  def feed
    # this will be the name of the feed displayed on the feed reader
    @title = "Squidtree"

    # the news items
    @posts = Post.paginate :per_page => 10, :order => 'created_at DESC'

    # this will be our Feed's update timestamp
    @updated = @posts.first.updated_at unless @posts.empty?

    respond_to do |format|
      format.atom { render :layout => false }

      # we want the RSS feed to redirect permanently to the ATOM feed
      format.rss { redirect_to feed_path(:format => :atom), :status => :moved_permanently }
    end
  end
end
