class UsersController < ApplicationController
  include LoginHelper
  # GET /users
  # GET /users.json
  def index
    if authenticated?
      if IsAdmin?
        @users = User.order(:name)

        respond_to do |format|
          format.html # index.html.erb
          format.json { render json: @users }
        end
      else
        redirect_to :controller => 'posts', :action => 'index'
      end

    else
      redirect_to :controller => 'login', :action => 'new'
    end

  end

  # GET /users/1
  # GET /users/1.json
  def show
    if authenticated?
      @user = User.find(params[:id])
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @user }
      end
    else
      redirect_to :controller => 'login', :action => 'new'
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    flash[:alert]="Administrator cannot edit user account details"
    redirect_to :controller => 'users', :action => 'index'
    if authenticated?
      @user = User.find(params[:id])
    end
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])
    respond_to do |format|
      if @user.save
        session[:user_loggedin]=true;
        session[:user_id]=@user.email
        session[:user_name]=@user.name
        cookies[:login]={:value=>@user.email,:expires=>Time.now+600}
        flash[:loginMessage]="You have Successfully logged in."
        format.html { redirect_to :controller => 'posts',:action => 'index'}
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def report
    if IsAdmin?
      @users=User.all
    else
    redirect_to :controller => "login", :action => "display"
    end

  end

  def admin
    if authenticated?
      action=params[:act]
      user_to=User.find(params[:id])
      if user_to
        if action=="grant"
          user_to.update_column(:isAdmin,true)
          flash[:alert]= "Admin rights have been granted to User #{user_to.name}"
          redirect_to :controller => 'users', :action => 'index'
        else
          user_to.update_column(:isAdmin,false)
          flash[:alert]="Admin rights have been revoked from User #{user_to.name}"
          redirect_to :controller => 'users', :action => 'index'
        end
      end
    else
      redirect_to :controller => 'login',:action => 'new'
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    if authenticated?
      @user = User.find(params[:id])
      respond_to do |format|
        if @user.update_attributes(params[:user])
          format.html { redirect_to(users_url, :notice=> "User #{@user.name} was successfully updated.") }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end
  else
    redirect_to :controller => 'login', :action => 'new'
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    if authenticated?
      @user = User.find(params[:id])
      @user.destroy

      respond_to do |format|
        format.html { redirect_to users_url }
        format.json { head :no_content }
      end
    else
      redirect_to :controller => 'login',:action => 'new'
    end

  end
end
