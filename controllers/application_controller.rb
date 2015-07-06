$:.unshift(File.expand_path('../../lib', __FILE__))

require 'sass'
require 'sinatra'
require 'sinatra/base'
require 'sinatra/activerecord'
require 'sinatra/reloader' if development?
require 'digest/sha1'
require './models/user.rb'
require './models/recipie.rb'
require './models/user.rb'
require './models/rating.rb'

class ApplicationController < Sinatra::Base
	
	# helpers ApplicationHelpers

	set :views, File.expand_path('../../views', __FILE__)
	enable :sessions, :method_override

	register Sinatra::Auth
 	register Sinatra::Flash

 	use AssetHandler

 	not_found{erb :not_found}
end