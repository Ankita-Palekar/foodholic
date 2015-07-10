# require 'bundler/setup'

# def require_directory(path)
# 	# require all *.rb files inside path
# end

require 'sass'
# require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/base'
require 'sinatra/activerecord'
require 'digest/sha1'
require 'rack-flash'
require 'sinatra/redirect_with_flash'
require 'pony'
require 'sinatra/twitter-bootstrap'
require 'sinatra/cookies'
# require 'sinatra/redirect_with_flash'
require './models/user.rb'
require './models/recipe.rb'
require './models/rating.rb'
require './models/ingredient.rb'
require './models/ingredients_recipe.rb'
require './models/category.rb'
require './controllers/application_controller.rb'
require './controllers/users_controller.rb'
require './controllers/ingredients_controller.rb'
require './controllers/recipes_controller.rb'
require './controllers/ingredients_recipies_controller.rb'
require './controllers/categories_controller.rb'
# require_directory('./models')
# require_directory('./controllers')
# Bundler.require(:default)


ActiveRecord::Base.establish_connection(
	:adapter => 'postgresql',
  :pool => 5,
  :timeout => 49,
  :encoding => 'utf8',
  :database => 'foodholic',
  :username =>	'foodholic',
  :password =>	'foodholic',
  :host => 'localhost')