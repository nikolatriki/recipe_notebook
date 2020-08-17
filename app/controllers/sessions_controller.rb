class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

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
    flash[:info] = "Goodbye!"
    redirect_to root_path
  end
end
