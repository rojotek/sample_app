class SessionsController < ApplicationController

  def new
    @title="Sign in"
  end

  def create
    session = params[:session]
    user = User.authenticate(session[:email], session[:password])
    if user.nil? then
      #wrong username + password
      flash.now[:error] = "Invalid email/password combination."
      @title="Sign in"
      render 'new'
    else
      #good username + password
    end
  end

  def destroy
  end

end
