class ApplicationController < Sinatra::Base
	set	:views, Proc.new	{File.join(root, "../views/")}
	enable :sessions, :method_override
	use Rack::MethodOverride
	register Sinatra::ActiveRecordExtension 
	register Sinatra::Twitter::Bootstrap::Assets
	use Rack::Flash

	# helpers Sinatra::RedirectWithFlash

	not_found{erb :not_found}

	helpers do
		def admin?
			session[:login]
		end
	end

	get '/login' do
		erb :login, :layout => :auth_layout
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
 		erb :signup, :layout => :auth_layout
 	end
	 	   
 	post '/signup' do
 		 

 		@user = User.new(params)
 		if @user.save
 			Pony.mail({
 			  :to => params[:email],
 			  :via => :smtp,
 			  :via_options => {
 			    :address              => 'smtp.mandrillapp.com',
 			    :port                 => '587',
 			    :enable_starttls_auto => true,
 			    :user_name            => '453ankitapalekar@gmail.com',
 			    :password             => 'WnEapPxX1PhaGAh2irMWBw',
 			    :authentication       => :plain, # :plain, :login, :cram_md5, no auth by default
 			    :domain               => "localhost:9292" # the HELO domain provided by the client to the server
 			  }
 			})
 			erb :home	
 		else
 			flash[:error] = @user.errors.full_messages
 			erb :signup
 		end
 	end	

 	get '/home' do
 		erb :home
 	end

 	get '/logout' do
 		session[:login] = false
 		session.clear
 		erb :login
 	end
end