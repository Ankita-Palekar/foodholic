require 'sass'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'sinatra/base'
require 'sinatra/activerecord'
require 'digest/sha1'
# require 'sinatra/flash'
require './models/user.rb'
require './models/recipe.rb'
require './models/rating.rb'
require './models/text.rb'
require './models/ingredient.rb'
require './models/ingredients_recipe.rb'

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
	@user = User.new(params)
	if @user.save
		erb :home	
	else
		"#{@user.errors.messages}"
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

	if @user && @user.authenticate(params[:password])
 		"youare logged in "
 		# @id = @user.id
 		# session[:login] = true
 		# session[:id] = @id
 		# redirect ("/home")
	else
		# erb :login
		# 
		 "wrong creds"
	end
end

get '/recipe/new' do
	erb :new_recipe
end

post '/recipe/new' do
	@login = params[:login]
	@user_id = params[:user_id]
	@rec_array = params.slice("title","method","ingredients","user_id")
	@recipe = Recipe.create(@rec_array)
	 # TODO needs to check if session exists before saving
	if @recipe.save
		redirect('/recipe/:#{@recipe.id}')
	else
		"There was error in your recipe"
	end		 
end


get '/recipe/:{id}' do
	erb :recipe
end


