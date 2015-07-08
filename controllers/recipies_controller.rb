class RecipiesController < ApplicationController

	get '/' do
	# @recipies  = Recipie.includes(:ratings).order("created_at DESC").all
	@recipies  = Recipie.joins("Left outer  join ratings on ratings.recipie_id = recipies.id").select("recipies.id, recipies.title, recipies.ingredients, recipies.method, count(ratings.recipie_id) as rate").group("recipies.id").order("rate desc, recipies.created_at asc")
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
		if admin?
			if @recipie.save
				redirect "/recipies/#{@recipie.id}" 
			else
				flash[:error] = @recipie.errors.full_messages
				erb :create_recipie
			end		 
		else
			flash[:notice] = "Session expired"
			erb :login	
		end
	end

	get	'/edit/:id'	do
		@recipie = Recipie.find(params[:id])
		erb :edit_recipie
	end

	post '/edit/:id'	do
		@recipie = Recipie.find(params[:id])
		@recipie.update_attributes(params.slice("title", "ingredients", "method", "user_id"))
		if admin?
			if @recipie.save
				redirect "/recipies/#{@recipie.id}" 
			else
				flash[:error] = @recipie.errors.full_messages
				erb :edit_recipie
			end
		else
			flash[:notice] = "Session expired"
			erb :login
		end
	end
end