module SessionsHelper
	def sign_in(user)
	  self.current_user = user
	end
	def current_user=(user)
	  @current_user = user
	end
	def current_user
	  @current_user ||= User.find(session[:user_id]) if session[:user_id]
	end
	def signed_in?
	    !current_user.nil?
	end
	def sign_out
	    self.current_user = nil
	end
	
	def signed_in_user
	   redirect_to root_path unless signed_in?
	end
end
