class ApplicationController < ActionController::Base
  include SessionsHelper

  before_action :require_login

  private

  def require_login
    unless logged_in?
      flash[:danger] = 'You must log in first.'
      redirect_to login_path
    end
  end
end
