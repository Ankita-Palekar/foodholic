require 'sinatra'
require "sinatra/reloader" if development?

class Stream
	def each
		100.times{|i| yield "#{i}\n"}
	end
end


get '/' do
	erb :index, :layout => :post
end


get '/code' do
	code = "<%= Time.now %>"
	erb code
end


get '/' do 
	erb	:index
end 


get '/' do
	File.read(File.join('public', 'index.html'))
end

get('/'){Stream.new}


get '/' do
	redirect "/hello"
end

get '/hello' do
	"This is redirected to hello"
end

get '/hello/:name' do
	params['captures']
  # "Hello world #{params['name']}"
end

get '/hello/:name' do |n|
	"this is some new things #{n}"
end

get '/travel/*/to/*' do
	params['splat']
end


get '/file/*.*' do
	params['splat']
end

get	'/posts.?:format?' do
	"#{params['captures']}"
end

get '/fun',:agent	=>	/Songbird(\d\.\d)[\d\/]*?/ do
	"You are using xyz version #{params['agent'][0]}"
end

get	'/', :host_name => /^admin\./ do
	"Admin area"
end


get '/', :provides => 'html' do
	 'html page should be redirected here '
end

get '/' do
	"trying out"
end 


get '/fun' do
	"non songbird browser"
end

post '/post' do
"#{params[:author]}
#{params[:title]}"
end 