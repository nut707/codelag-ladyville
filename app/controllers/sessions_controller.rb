class SessionsController < ApplicationController
  def new
    flash.clear
  end

  def create
    user = User.authenticate(post_params)
    if user
      session[:user_id] = user.id
      sign_in user
      redirect_to reports_path
    else
      flash.now.alert = "Invalid login or password"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    sign_out
    redirect_to root_url
  end

  private
  def post_params
    params.require(:session).permit(:login, :password)
  end
end
