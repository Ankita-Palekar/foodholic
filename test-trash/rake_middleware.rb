require 'sinatra/base'

class MyApp < Sinatra::Base
	set	:sessions, true
	set :foo, 'bar'
	get '/' do
		'hello'
	end
end