class ApplicationController < Sinatra::Base

	set	:views, Proc.new	{File.join(root, "../views/")}
	set :public_folder , Proc.new {File.join(root,"../public")}
	enable :static
	enable :sessions, :method_override
	use Rack::MethodOverride
	register Sinatra::ActiveRecordExtension 
	register Sinatra::Twitter::Bootstrap::Assets
	ActiveRecord::Base.include_root_in_json = true
	use Rack::Flash
	helpers Sinatra::RedirectWithFlash
	helpers Sinatra::Cookies
	
	not_found{redirect "/404"}

	helpers do
		def admin?
			session[:login] | cookies[:login]
		end
	end

	get '/404' do
		erb :not_found
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
 	 		cookies[:login] = true
 	 		cookies[:id] = @id 
 	 		redirect ("/")
	 	else
	 		flash[:notice] = "EmailId password do not match"  
	 		puts "#{flash[:notice]}"
			redirect "/login"
		end
	end

 	get '/signup' do
 		erb :signup, :layout => :auth_layout
 	end
	 	   
 	post '/signup' do
 		@user = User.new(params)
 		puts params
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

 			redirect '/'
 		else
 			flash[:error] = @user.errors.full_messages
 			erb :signup
 		end
 	end	

 	get '/' do
 		erb :index
 	end

 	get '/logout' do
 		session[:login] = false
 		cookies.delete :login
 		cookies.delete :id
 		session.clear
 		redirect "/login"
 	end
end