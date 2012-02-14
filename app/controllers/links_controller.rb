class LinksController < ApplicationController
  # GET /links
  # GET /links.json
  def index
    options = {
      :page => params[:page],
      :per_page => 10,
      :order => 'created_at DESC'
    }

    if params[:month]
      month_param = params[:month]

      month = Date.parse month_param

      options[:created_at] = {
        '$lt' => (month >> 1).midnight,
        '$gt' => month.midnight
      }
    elsif params[:user]
      user = User.find_by_slug(params[:user])

      options[:user_id] = user.id
    elsif params[:search]
      search = params[:search]

      regex = Regexp.new(Regexp.escape(search), Regexp::IGNORECASE)
      options["$or"] = [
        {:comment => regex},
        {:url => regex},
        {:title => regex}
      ]
    end

    @links = Link.paginate(options)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @links, :include => {:user => {:methods => :name, :only => [:name]}}}
    end
  end

  # GET /links/1
  # GET /links/1.json
  def show
    @link = Link.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @link }
    end
  end

  # GET /links/new
  # GET /links/new.json
  def new
    @link = Link.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @link }
    end
  end

  # GET /links/1/edit
  def edit
    @link = Link.find(params[:id])
  end

  # POST /links
  # POST /links.json
  def create
    @link = Link.new(params[:link])

    respond_to do |format|
      if @link.save
        format.html { redirect_to @link, notice: 'Link was successfully created.' }
        format.json { render json: @link, status: :created, location: @link }
      else
        format.html { render action: "new" }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /links/1
  # PUT /links/1.json
  def update
    @link = Link.find(params[:id])

    respond_to do |format|
      if @link.update_attributes(params[:link])
        format.html { redirect_to @link, notice: 'Link was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /links/1
  # DELETE /links/1.json
  def destroy
    @link = Link.find(params[:id])
    @link.destroy

    respond_to do |format|
      format.html { redirect_to links_url }
      format.json { head :ok }
    end
  end
end
