#This file is used by sinatra to run the app directly 


#code for runnign app with rackup

require "./config/environment"

use Rack::Session::Cookie, 
   :path => '/',
   :expire_after => 14400, # In seconds
	 :secret => 'session_set'

 

map "/user" do
	run UserController 
end  

map "/recipe" do
	run RecipesController
end 

map "/recipes" do
	run RecipesController
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
