class IngredientRecipe < ActiveRecord::Base
	belongs_to :recipes
	belongs_to :ingredients
end