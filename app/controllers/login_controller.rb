class LoginController < ApplicationController
  include LoginHelper
  def create
    if user=User.authenticate(params[:userName],params[:password])
      cookies[:login]={:value=>user.email,:expires=>Time.now+600}
      session[:user_id]=user.id
      session[:user_name]=user.name
      flash[:loginMessage]="You have Successfully logged in."
      if user.isAdmin
        session[:isadmin]=true
        redirect_to :controller => 'users', :action => 'index',:method=>'get'
      else
        redirect_to :controller => 'posts', :action => 'index',:method => 'get'
      end
    else
      flash[:alert]="Invalid UserName or Password"
      redirect_to :controller => 'login', :action => 'new'
    end
  end


  def destroy
    if authenticated?
      cookies.delete :login
      session[:user_id]=nil
      session[:user_name]=nil
      session[:isadmin]=nil
      redirect_to :controller => 'login', :action => 'new'
    else
      render :action => new
    end

  end

  def display
    if authenticated?
      @logged_in_user=session[:user_name]
    else
      render :action => :new
    end

  end

  def new
   end
end
