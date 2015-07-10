class IngredientsRecipe < ActiveRecord::Base
	belongs_to :recipes
	belongs_to :ingredients

	def create_new_ingredients_recipe(recipes_id, ingredients_id)
		@recipes_id  = recipes_id
		@ingredients_id - ingredients_id
	end
end
 
