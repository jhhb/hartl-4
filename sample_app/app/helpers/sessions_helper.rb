module SessionsHelper

	def sign_in(user)
		remember_token = User.new_remember_token # Create a new token
		cookies.permanent[:remember_token] = remember_token # Set the token in the browser cookies
		user.update_attribute(:remember_token, User.digest(remember_token)) # Save the hashed token to the database
		# Update_attribute bypasses validation
		self.current_user = user # Set the current user to the given user 
	end

	def sign_out
		# Change user's token so that their session cannot be hijacked
		current_user.update_attribute(:remember_token, 
			User.digest(User.new_remember_token))

		# Delete token from cookies
		cookies.delete(:remember_token)
		
		self.current_user = nil
	end

	def current_user=(user)
		@current_user = user
	end

	def current_user
		remember_token = User.digest(cookies[:remember_token])
		@current_user ||= User.find_by(remember_token: remember_token)
	end

	def signed_in?
		return !current_user.nil?
	end
end
