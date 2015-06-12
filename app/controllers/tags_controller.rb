class TagsController < ApplicationController
  before_action :set_tag, only: [:show, :edit, :update, :destroy]
  before_action :find_book, only: [:new_tags]

  # GET /tags
  # GET /tags.json
  def index
    @tags = Tag.all#.search(params[:query])
  end

  def search
    @tags = Tag.search(params[:query])
    respond_to do |format|
      format.js
      format.html # index.html.erb
      format.xml  { render :xml => @currencies }
    end
  end

  def autocomplete_for_tag
    @tags = books_for_new_tag
    render :layout => false
  end

  def attach_tags
    @tags = params[:books][:tag_ids] if params[:books].present?
    # debugger
    # if params[:watcher].is_a?(Hash)
    #   user_ids = params[:watcher][:user_ids] || [params[:watcher][:user_id]]
    #   @users = User.active.where(:id => user_ids).all
    # end
    # if @users.blank?
    #   render :nothing => true
    # end
  end
  # GET /tags/1
  # GET /tags/1.json
  def show
  end

  # GET /tags/new
  def new
    @tag = Tag.new
  end

  def new_tags
    @tags = books_for_new_tag
  end
    
  # GET /tags/1/edit
  def edit
  end

  # POST /tags
  # POST /tags.json
  def create
    @tag = Tag.new(tag_params)

    respond_to do |format|
      if @tag.save
        format.html { redirect_to @tag, notice: 'Tag was successfully created.' }
        format.json { render :show, status: :created, location: @tag }
      else
        format.html { render :new }
        format.json { render json: @tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tags/1
  # PATCH/PUT /tags/1.json
  def update
    respond_to do |format|
      if @tag.update(tag_params)
        format.html { redirect_to @tag, notice: 'Tag was successfully updated.' }
        format.json { render :show, status: :ok, location: @tag }
      else
        format.html { render :edit }
        format.json { render json: @tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tags/1
  # DELETE /tags/1.json
  def destroy
    @tag.destroy
    respond_to do |format|
      format.html { redirect_to tags_url, notice: 'Tag was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tag
      @tag = Tag.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tag_params
      params.require(:tag).permit(:name)
    end

    def books_for_new_tag
      tags = []
      if !params[:q].blank? #&& @book.present?
        tags = Tag.where('name LIKE ?', "%#{params[:q]}%")
      elsif @book.present?
        tags = @book.tags
      else
        tags
      #   tags = Tag.like(params[:q]).limit(10)
      #   # tags = User.active.sorted.like(params[:q]).limit(100)
      end
      # if params[:q].blank? #&& @project.present?
        # books = books.sorted
      # else
        # require 'debugger'
        # books = Tag.sorted#.like()
        # books = User.active.sorted.like(params[:q]).limit(100)
      # end
      # if @watched
      #   users -= @watched.watcher_users
      # end
      tags
    end

    def find_book
      @book = Book.find(params[:book_id]) unless params[:book_id].blank?
    end

end
