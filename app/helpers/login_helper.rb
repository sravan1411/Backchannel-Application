module LoginHelper
  def authenticated?
      if cookies[:login] != nil
        true
      else
        false
      end
  end

  def authenticated
    if cookies[:login]!=nil
      true
    else
      redirect_to :controller=>'login', :action=> 'new'
    end
  end

  def IsAdmin?
    if authenticated?
      if session[:isadmin]
        true
      else
        false
      end
    else
      false
    end

  end

  def current_user
    if authenticated?
      session[:user_id]
    end
  end

  def IsCreatedByCurrentUser? (user_id)
     if user_id == current_user
       true
     else
       false
    end
  end

end
