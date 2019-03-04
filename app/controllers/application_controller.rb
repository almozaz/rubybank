class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def login

  end

  def authenticate
    authorized_user = User.login(params[:username], params[:password],
                                  params[:password_confirmation])
    if authorized_user
      session[:user_id] = authorized_user.id
      flash[:success] = "You are now logged in"
      redirect_to(:action => 'home')
    else
      flash[:warning] = "Invalid username or password"
      redirect_to(:action => 'login')
    end
  end

  def home
    if session[:user_id].blank?
      return redirect_to(:action => 'login')
    end

    @user = User.find(session[:user_id])
  end

  def logout
    session[:user_id] = nil
    redirect_to :action => 'login'
  end
end
