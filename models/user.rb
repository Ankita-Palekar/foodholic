class User < ActiveRecord::Base
	has_many :recipes
	has_many :ratings

	EMAIL_REGEX	=	/([A-Z]|[a-z]|[0-9])\w+(.)*@([a-z]|[A-Z]|[0-9])\w+(.)([a-z]|[A-z]|[0-9])+/

	attr_accessible :email, :password, :password_confirmation, :name
	has_secure_password
 	validates_presence_of :password, :on => :create
	validates :email, :presence	=>	true, :uniqueness	=>	true,	:format	=>	EMAIL_REGEX
end