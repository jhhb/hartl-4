class User < ActiveRecord::Base
	before_save { self.email = email.downcase }
	validates :name, presence: true, length: { maximum: 50 } 
	# optional regex that is tested against user-passed email 
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
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
end
