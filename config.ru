#This file is used by sinatra to run the app directly 
#require "./app"

require "./config/environment"

#use Rack::Session::Cookie, 
#    :key => 'id',
#    :path => '/',
#    :expire_after => 14400, # In seconds
# 	 :secret => 'change_me'

map "/user" do
	run UserController
end  
run ApplicationController
#run Sinatra::Application

