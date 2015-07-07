# require 'bundler/setup'

def require_directory(path)
	# require all *.rb files inside path
end

require 'sass'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/base'
require 'sinatra/activerecord'
require 'digest/sha1'
require 'rack-flash'
require './models/user.rb'
require './models/recipie.rb'
require './models/rating.rb'
require './models/text.rb'
require './controllers/application_controller.rb'
require './controllers/users_controller.rb'
require './controllers/recipies_controller.rb'

require_directory('./models')
require_directory('./controllers')
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