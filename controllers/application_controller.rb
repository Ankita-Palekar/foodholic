class ApplicationController < Sinatra::Base
	register Sinatra::ActiveRecordExtension
	set	:views, Proc.new	{File.join(root, "../views/")}
	enable :sessions, :method_override
	 # not_found{erb :not_found}
	 get '/application' do 
	 		"Application controller "
	 end
end