class RecipesController < ApplicationController

	def create_ingredient_recipe_join(recipies_id, ingredients_id)
		ingredient_recipe = IngredientsRecipe.new
		ingredient_recipe.ingredients_id = ingredients_id
		ingredient_recipe.recipes_id = recipies_id
		if ingredient_recipe.save
			flash[:notice] = "ingredient recipe join created successfully"
		else
			flash[:error] = @recipe.errors.full_messages
			erb :create_recipe
		end
	end

	def create_ingredient(name)
		ingredient = Ingredient.new 
		ingredient.name = name
		if ingredient.save
			ingredient.id
		else
			flash[:error] = "ingredients did not get saved properly"
			false
		end
	end

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
			recipe_array = params.slice("title", "method", "user_id")
			ingredients = params[:ingredients]
			db_ingredients = JSON.parse params[:db_ingredients] 
			recipe = Recipe.create(recipe_array)	

		# TODO write exception block for recue
		# begin
		# 	recipe.save!
		# 	recipe_id = recipe.id
		# 	if ingredient.nil?
		# 		raise "selct atleast one ingredient"
		# 	end
		# 	ingredients.each do |ingredient|
		# 		if db_ingredients.has_value?(ingredient)	
		# 			ingredient_id = db_ingredients.key(ingredient)
		# 			create_ingredient_recipe_join(recipe_id, ingredient_id)
		# 		else
		# 			ingredient_id = create_ingredient(ingredient)
		# 			if !ingredient_id
		# 				raise "Ingredients not saved preoperly"
		# 			end
		# 			create_ingredient_recipe_join(recipe_id, ingredient_id)
		# 		end
		# 	end		
		# 	redirect "/recipes/#{@recipe.id}" 
		# rescue Exception => e
		# 	flash[:errors] = e
		# 	erb :create_recipe
		# end

		if !ingredients.nil?		
			if admin?
				if recipe.save		
					recipe_id = recipe.id
					ingredients.each do |ingredient|
						if db_ingredients.has_value?(ingredient)	
							ingredient_id = db_ingredients.key(ingredient)
							create_ingredient_recipe_join(recipe_id, ingredient_id)
						else
							ingredient_id = create_ingredient(ingredient)
							if ingredient
								create_ingredient_recipe_join(recipe_id, ingredient_id)
							end
						end
					end		 
					redirect "/recipes/#{recipe.id}" 
				else
					flash[:error] = recipe.errors.full_messages
					erb :create_recipe
				end		 
			else
				flash[:notice] = "Session expired"
				redirect '/login'	
			end
		else
			flash[:error] = "selct atleast one ingredient"
			erb :create_recipe
		end
	end

	get	'/edit/:id'	do
		@recipe = Recipe.find(params[:id])
		erb :edit_recipe
	end

	post '/edit/:id'	do
		recipe = Recipe.find(params[:id])
		recipe.update_attributes(params.slice("title", "method", "user_id"))
		if admin?
			if recipe.save
				redirect "/recipes/#{recipe.id}" 
			else
				flash[:error] = recipe.errors.full_messages
				erb :edit_recipe
			end
		else
			flash[:notice] = "Session expired"
			redirect '/login'
		end
	end
end