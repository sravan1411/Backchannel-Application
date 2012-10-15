class PostsController < ApplicationController
  include LoginHelper
  include Comparable
  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.order("updated_at DESC")
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
  end

  def <=>(other)
    if self.title == other.title
      0
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])
    @votes=@post.p_votes
    @vote=@votes.where(:User_id=>session[:user_id])
    if @vote.first
      @voted=true
    else
      @voted=false
    end
    @username=User.find(@post.User_id).name
    @comments=Comment.where(:Post_id=>@post.id)


    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end

  def vote
    @p_vote=PVote.new
    post_id=params[:id]
    @post=Post.find(post_id)
    @p_vote.Post_id=post_id
    @p_vote.User_id=session[:user_id]
    if @p_vote.save!
      @post.update_column(:updated_at,Time.now)
      redirect_to :controller => 'posts',:action => 'show',:id=>post_id
    else
      redirect_to :controller => 'posts',:action => 'index'
    end
  end



  # GET /posts/new
  # GET /posts/new.json
  def new
    @post = Post.new
    @categories=Category.all

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
    @categories=Category.all
  end


  def search
    searchstring=params[:searchparam]
    if (searchstring==nil) || (searchstring=="")
      flash[:alert]="Search string cannot be empty"
      if authenticated?
        redirect_to posts_path
      else
        redirect_to login_path
      end
    else
      @results= Post.where("content LIKE ?","%#{searchstring}%")
      @users=User.where("name LIKE ?","%#{searchstring}%")
      @users.each do |user|
        @userposts=Post.all(:conditions=>{:User_id=>user.id})
        @userposts.each do |post|
          @results << post
        end
      end


      @categories=Category.where("name LIKE ?","%#{searchstring}%")
      @categories.each do |category|
        @cposts=Post.all(:conditions=> {:Category_id =>category.id } )
        @cposts. each do |post|
          @results << post
        end
        @results.
        respond_to do |format|
          format.html # new.html.erb
          format.json { render json: @resuts }
        end
      end


    end
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(params[:post])
    user_id=session[:user_id]
    @post.User_id=user_id

    respond_to do |format|
      if @post.save
        format.html { redirect_to :controller => 'posts', :action => 'index', notice: 'Post was successfully created.' }
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
    @post = Post.find(params[:id])
    user_id=current_user
    if user_id
      @post.User_id= user_id
    end

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to :controller => 'posts', :action => 'index', notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
  end
private
  def login_required
    if !cookies[:login]
      redirect_to :controller => 'login',:action => 'new'
    end
  end

end
