#This file is used by sinatra to run the app directly 


#code for runnign app with rackup

require "./config/environment"
use Rack::Session::Cookie, 
   :key => 'id',
   :path => '/',
   :expire_after => 14400, # In seconds
	 :secret => 'change_me'

map "/user" do
	run UserController 
end  

map "/recipie" do
	run RecipiesController
end 

map "/recipies" do
	run RecipiesController
end 


run ApplicationController

#code for runnning stand alon app
# require "./app"


# use Rack::Session::Cookie, 
#    :key => 'id',
#    :path => '/',
#    :expire_after => 14400, # In seconds
# 	 :secret => 'change_me'
# run Sinatra::Application
