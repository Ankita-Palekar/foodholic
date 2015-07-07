class User < ActiveRecord::Base
	has_many :recipies
	has_many :ratings
	EMAIL_REGEX	=	/([A-Z]|[a-z]|[0-9])\w+(.)*@([a-z]|[A-Z]|[0-9])\w+(.)([a-z]|[A-z]|[0-9])+/
	validates :email, :presence	=>	true, :uniqueness	=>	true,	:format	=>	EMAIL_REGEX
	validates :name, :presence	=>	true
	validates :password,	length: {in: 6..20}, :presence => true


	def self.encrypt(pass)
		return  Digest::SHA1.hexdigest(pass)
	end
	
end