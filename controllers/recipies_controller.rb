class RecipiesController < ApplicationController

	get '/' do
		@recipies  = Recipie.all
		erb :recipies
	end

	get '/create' do
		erb :create_recipie
	end

	get '/:id' do
		@recipie = Recipie.find(params[:id])
		erb :recipie
	end

	post '/create' do
		@login = params[:login]
		@user_id = params[:user_id]
		@rec_array = params.slice("title",	"method",	"ingredients",	"user_id")
		@recipie = Recipie.create(@rec_array)
		 # TODO needs to check if session exists before saving
		if @recipie.save
			redirect "/recipies/#{@recipie.id}" 
		else
			erb :create_recipie
		end		 
	end

	get	'/edit/:id'	do
		@recipie = Recipie.find(params[:id])
		erb :edit_recipie
	end

	post '/edit/:id'	do
		@recipie = Recipie.find(params[:id])
		@recipie.update_attributes(params.slice("title", "ingredients", "method", "user_id"))
		if @recipie.save
			redirect "/recipies/#{@recipie.id}" 
		else
			"cannot be edited"
		end
	end

end