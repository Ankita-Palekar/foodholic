class ApplicationController < Sinatra::Base
	register Sinatra::ActiveRecordExtension
	use Rack::Flash
 
	 
	set	:views, Proc.new	{File.join(root, "../views/")}
	enable :sessions, :method_override

	not_found{erb :not_found}
	
	get '/login' do
		erb :login
	end
	 	
	post '/login' do
	 	@user = User.find_by_email(params[:email])
	 	if @user && @user.authenticate(params[:password]) 
 	 		@id = @user.id
 	 		session[:login] = true
 	 		session[:id] = @id
 	 		redirect ("/home")
	 	else
	 		flash[:notice] = "EmailId password do not match"
			erb :login 
		end
	end

 	get '/signup' do
 		erb :signup
 	end
	 	   
 	post '/signup' do
 		@user = User.new(params)
 		if @user.save
 			erb :home	
 		else
 			flash[:error] = @user.errors.messages
 			"#{flash[:error]}"
 			# erb :signup
 		end
 	end	


 	get '/home' do
 		erb :home
 	end
end