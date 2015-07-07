class User < ActiveRecord::Base
	has_many :recipies
	has_many :ratings

	EMAIL_REGEX	=	/([A-Z]|[a-z]|[0-9])\w+(.)*@([a-z]|[A-Z]|[0-9])\w+(.)([a-z]|[A-z]|[0-9])+/

	attr_accessible :email, :password, :password_confirmation, :name
	has_secure_password
 	validates_presence_of :password, :on => :create
	validates :email, :presence	=>	true, :uniqueness	=>	true,	:format	=>	EMAIL_REGEX
	
		
# def self.authenticate(email, password)
#    user = find_by_email(email)
#    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
#     user
#    else
#     nil
#    end
# 	end

# 	def encrypt_password
#     if password.present?
#       self.password_salt = BCrypt::Engine.generate_salt
#       self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
#     end
# 	end

# 	def password=(unencrypted_password)
#    unless unencrypted_password.blank?
#     @password = unencrypted_password
#    end
# 	end

# 	def password_confirmation=(unencrypted_password)
# 	  @password_confirmation = unencrypted_password
# 	end	
end