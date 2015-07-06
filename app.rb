require 'sass'
require 'sinatra'
require 'sinatra/base'
require 'sinatra/activerecord'
require 'sinatra/reloader' if development?
require './models/user.rb'
require './models/recipie.rb'
require './models/user.rb'
require './models/rating.rb'


configure :development do
	set :database, 'postgres://foodholic:foodholic@localhost/foodholic'
	db = URI.parse('postgres://foodholic:foodholic@localhost/foodholic')

	ActiveRecord::Base.establish_connection(
	  :adapter  => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
	  :host     => db.host,
	  :username => db.user,
	  :password => db.password,
	  :database => db.path[1..-1],
	  :encoding => 'utf8'
	) 
end

configure do
	enable :sessions
	set :username, 'ankita'
	set :password, 'ankita'
end


get '/login' do
	erb :login
end

post '/login' do
	if settings.username==params[:name] && settings.password == params[:password]
		 session[:admin] = true
		 "you are logged in now"
	else  
		erb :login
	end
end


get '/signup' do
	erb :signup
end

get '/set/:name' do
	session[:name] = params[:name]
end

get '/get/hello' do
	"Hello #{session[:name]}"
end


get '/recipie/new' do
"#{session}"

	# halt(401,'Not Authorized') unless session[:admin]
	# "you are free to create"
end

post '/signup' do
	 "#{@params}" 
	 @user = User.create(@params["post"])
end