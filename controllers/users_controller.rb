require_relative 'user_controller.rb'

class UserController < ApplicationController
	
	get '/login' do
		erb :login
	end

	get '/reloader' do
		"reloader has ben modified agaian"
	end

	post '/user/login' do
		"login"
		# @user = User.find_by_email(params[:email])
		# @user_pasword = User.encrypt(params[:password])
		# if @user_pasword==@user.encrypted_password
	 # 		@id = @user.id
	 # 		session[:login] = true
	 # 		session[:id] = @id
	 # 		redirect ("/home")
		# else
		# 	erb :login
		# end
	end
end
