require 'sass'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'sinatra/base'
require 'sinatra/activerecord'
require 'digest/sha1'
require 'sinatra/flash'
require './models/user.rb'
require './models/recipie.rb'
require './models/rating.rb'
require './models/text.rb'


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
 


configure :production do
	set :database, 'postgres://yxfesuoktezyzw:tDsHhHII6o5sDC5XzITFym-pr0@ec2-107-20-223-116.compute-1.amazonaws.com:5432/d32pnml5uniaro'
	db = URI.parse('postgres://yxfesuoktezyzw:tDsHhHII6o5sDC5XzITFym-pr0@ec2-107-20-223-116.compute-1.amazonaws.com:5432/d32pnml5uniaro')

	ActiveRecord::Base.establish_connection(
	  :adapter  => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
	  :host     => db.host,
	  :username => db.user,
	  :password => db.password,
	  :database => db.path[1..-1],
	  :encoding => 'utf8'
	) 
end


# will enable session when logging in 

configure do
	enable :sessions
end

get '/signup' do
	erb :signup
end
   
post '/signup' do
	@encrypted_password= User.encrypt(params[:post][:password])
	@array  = params[:post].slice("name","email") 
	@array["encrypted_password"] = @encrypted_password
	@user = User.create(@array)
	if @user.save!
		 erb :login
	else
		 erb :signup
	end
end

get '/login' do
	erb :login
end

get '/home' do
	erb :home
end

post '/login' do
	@user = User.find_by_email(params[:email])
	@user_pasword = User.encrypt(params[:password])
	
	if @user_pasword==@user.encrypted_password
 		@id = @user.id
 		session[:login] = true
 		session[:id] = @id
 		redirect ("/home")
	else
		erb :login
	end
end

get '/recipie/new' do
	erb :new_recipie
end

post '/recipie/new' do
	@login = params[:login]
	@user_id = params[:user_id]
	@rec_array = params.slice("title","method","ingredients","user_id")
	@recipie = Recipie.create(@rec_array)
	 # TODO needs to check if session exists before saving
	if @recipie.save
		redirect('/recipie/:#{@recipie.id}')
	else
		"There was error in your recipie"
	end		 
end


get '/recipie/:{id}' do
	erb :recipie
end


