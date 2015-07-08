class UserController < ApplicationController
	post '/sendmail' do
		Pony.mail({
		  :to => '453ankitapalekar@gmail.com',
		  :via => :smtp,
		  :via_options => {
		    :address              => 'smtp.mandrillapp.com',
		    :port                 => '587',
		    :enable_starttls_auto => true,
		    :user_name            => '453ankitapalekar@gmail.com',
		    :password             => 'WnEapPxX1PhaGAh2irMWBw',
		    :authentication       => :plain, # :plain, :login, :cram_md5, no auth by default
		    :domain               => "localhost:9292" # the HELO domain provided by the client to the server
		  }
		})
	end	 
end
