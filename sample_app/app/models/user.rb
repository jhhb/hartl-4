class User < ActiveRecord::Base
	before_save { email.downcase! } # alternative syntax: { self.email = email.downcase }
	before_create :create_remember_token

	validates :name, presence: true, length: { maximum: 50 } 
	# optional regex that is tested against user-passed email 
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i

	# case_insensitive uniqueness check.
	# Other steps: Need to add unique index to database and before_save on email
	validates :email, 
		presence: true, 
		format: { with: VALID_EMAIL_REGEX }, 
		uniqueness: {case_sensitive: false}
	validates :password, length: { minimum: 6 }

	# as long as there is a password_digest column in the database, this method
	# is fine.
	has_secure_password

	def User.new_remember_token
		SecureRandom.urlsafe_base64
	end

	def User.digest(token)
		Digest::SHA1.hexdigest(token.to_s)
	end


	private
		def create_remember_token
			self.remember_token = User.digest(User.new_remember_token)
		end
end
