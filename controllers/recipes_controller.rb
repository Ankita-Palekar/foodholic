class RecipesController < ApplicationController

	configure do
		enable :sessions 
	end


	get '/' do
	# @recipes  = recipe.includes(:ratings).order("created_at DESC").all
	@recipes  = Recipe.joins("Left outer  join ratings on ratings.recipe_id = recipes.id").select("recipes.id, recipes.title, recipes.method, count(ratings.recipe_id) as ratings_count").group("recipes.id").order("ratings_count desc, recipes.created_at asc")
		erb :recipes
	end

	get '/create' do
		erb :create_recipe
	end

	get '/:id' do
		@recipe = Recipe.find(params[:id])
		erb :recipe
	end

	post '/create' do
		@login = params[:login]
		@user_id = params[:user_id]
		@rec_array = params.slice("title", "method", "user_id")
		@recipe = Recipe.create(@rec_array)
		if admin?
			if @recipe.save
				redirect "/recipes/#{@recipe.id}" 
			else
				flash[:error] = @recipe.errors.full_messages
				erb :create_recipe
			end		 
		else
			flash[:notice] = "Session expired"
			redirect '/login'	
		end
	end

	get	'/edit/:id'	do
		@recipe = Recipe.find(params[:id])
		erb :edit_recipe
	end

	post '/edit/:id'	do
		@recipe = Recipe.find(params[:id])
		@recipe.update_attributes(params.slice("title", "method", "user_id"))
		if admin?
			if @recipe.save
				redirect "/recipes/#{@recipe.id}" 
			else
				flash[:error] = @recipe.errors.full_messages
				erb :edit_recipe
			end
		else
			flash[:notice] = "Session expired"
			redirect '/login'
		end
	end
end