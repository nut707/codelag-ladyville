class User < ActiveRecord::Base
	attr_reader :password
	before_save :encrypt_password
	validates_confirmation_of :password
	validates_presence_of :password, :on => :create

	def encrypt_password
	  if password.present?
	    self.password_salt = BCrypt::Engine.generate_salt
	    self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
	  end
	end
	
	def self.authenticate(params)
	  user = find_by_login(params[:login])
	  if user && user.password_hash == BCrypt::Engine.hash_secret(params[:password], user.password_salt)
	    user
	  else
	    nil
	  end
	end

	def password=(unencrypted_password)
	  unless unencrypted_password.blank?
	    @password = unencrypted_password
	  end
	end

	##
	# accessor
	def password_confirmation=(unencrypted_password)
	  @password_confirmation = unencrypted_password
	end
end
