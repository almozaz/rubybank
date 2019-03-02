class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def login
    authorized_user = User.login(params[:username], params[:password],
                                  params[:password_confirmation])

    if authorized_user
      session[:user_id] = authorized_user.id
      flash[:notice] = "You are now logged in"
      redirect_to(:action => 'home')
    else

      flash[:notice] = "Invalid username or password"
      flash[:color]= "invalid"
      render "login"
    end
  end
  def home
    @user = User.find(session[:user_id])

  end

  def logout
    session[:user_id] = nil
    redirect_to :action => 'login'
  end
end
