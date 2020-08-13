class SessionsController < ApplicationController
  def new
    session_notice(:warning, 'You are already logged in!') if logged_in?
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)

    if user &.authenticate(params[:session][:password])
      log_in(user)
      flash[:success] = "Welcome #{user.handle} !"
      redirect_to user
    else
      flash.now[:danger] = 'Invalid email and/or password'
      render :new
    end
  end

  def destroy
    log_out
    redirect_to root_path
  end
end
