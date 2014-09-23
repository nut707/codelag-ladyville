class UsersController < ApplicationController
	def new
	  @user = User.new
	end
	
	def create
	  @user = User.new(post_params)
	  if @user.save
	    redirect_to root_url
	  else
	    render "new"
	  end
	end
	private
	def post_params
	  params.require(:user).permit(:login, :password, :password_confirmation)
	end
end
