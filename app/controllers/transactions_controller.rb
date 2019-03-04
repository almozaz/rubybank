class TransactionsController < ApplicationController
  def make_deposit
    current_user = User.find(session[:user_id])

    transaction = current_user.give_credit(params[:username], params[:amount])

    if transaction[:successful]
      flash[:success] = transaction[:message]
      redirect_to(:action => 'home', :controller => 'application')
    else
      flash[:warning] = transaction[:message]
      redirect_to(:action => 'home', :controller => 'application')
    end
  end
end
