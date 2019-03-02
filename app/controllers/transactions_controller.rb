class TransactionsController < ApplicationController
  def make_deposit
    current_user = User.find(session[:user_id])
    user = params[:username]
    amount = params[:amount]

    transaction = current_user.give_credit(user, amount)
    # flash confirmation or rejection
    if transaction[:successful]
      flash[:notice] = transaction[:message]

      redirect_to(:action => 'home', :controller => 'application')
    else
      flash[:notice] = transaction[:message]
      flash[:color]= "invalid"
      redirect_to(:action => 'home', :controller => 'application')
    end
  end
end
