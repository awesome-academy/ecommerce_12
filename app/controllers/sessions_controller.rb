class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user&.authenticate(params[:session][:password])
      log_in user
      remember? user
      redirect_to root_url
    else
      flash.now[:danger] = t ".danger_login"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  private

  def remember? user
    if params[:session][:remember_me] == Settings.remember_session
      remember user
    else
      forget user
    end
  end
end
