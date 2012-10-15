class CommentsController < ApplicationController
  # GET /comments
  # GET /comments.json
  def index
    redirect_to :controller => 'posts', :action => 'index'
    #@comments = Comment.all
    #respond_to do |format|
      #format.html # index.html.erb
      #format.json { render json: @comments }
    #end
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
    @comment = Comment.find(params[:id])
    post_id=@comment.Post_id
    redirect_to :controller => 'posts',:action => 'show',:id=>post_id
    #respond_to do |format|
      #format.html # show.html.erb
      #format.json { render json: @comment }
    #end
  end

  # GET /comments/new
  # GET /comments/new.json
  def new
    @comment = Comment.new
    post_id=params[:post_id]
    @post=Post.find(post_id)
    @username=session[:user_name]
    @otherComments=Comment.where(:Post_id=>post_id)

    session[:post_id]=post_id

     if @post
       respond_to do |format|
         format.html # new.html.erb
         format.json { render json: @comment }
       end
     end

  end

  def vote
    @c_vote=CVote.new
    @c_vote.User_id=session[:user_id]
    @c_vote.Comment_id=params[:id]
    post_id=Comment.find(params[:id]).Post_id
    @post=Post.find(post_id)
    if @c_vote.save!
      @post.update_column(:updated_at,Time.now)
      redirect_to :controller => 'posts',:action => 'show',:id=>post_id
    else
      redirect_to :controller => 'posts',:action => 'index'
    end
  end

  # GET /comments/1/edit
  def edit
    post_id=params[:post_id]
    @post=Post.find(post_id)
    @username=session[:user_name]
    @otherComments=Comment.where(:Post_id=>post_id)

    session[:post_id]=post_id
    @comment = Comment.find(params[:id])

  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = Comment.new(params[:comment])
    post_id=session[:post_id]
    @post=Post.find(post_id)
    session[:post_id]=nil
    user_id=session[:user_id]
    @comment.Post_id=post_id
    @comment.User_id=user_id

    respond_to do |format|
      if @comment.save
        @post.update_column(:updated_at,Time.now)
        format.html { redirect_to :controller => 'posts', :action => 'index'}
        format.json { render json: @comment, status: :created, location: @comment }
      else
        format.html { render action: "new" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /comments/1
  # PUT /comments/1.json
  def update
    post_id=session[:post_id]
    session[:post_id]=nil
    @post=Post.find(post_id)
    user_id=session[:user_id]
    @comment = Comment.find(params[:id])
    @comment.Post_id==post_id


    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        @post.update_column("updated_at", "#{Time.now}")
        format.html { redirect_to :controller => 'posts', :action => 'index' }
        #format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
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
    @comment.destroy
    post_id=params[:post_id]
    respond_to do |format|
      format.html { redirect_to :controller => 'posts', :action => 'show', :id=>post_id  }
      format.json { head :no_content }
    end
  end
end
