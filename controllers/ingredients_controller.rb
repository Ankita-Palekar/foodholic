class IngredientsController < ApplicationController
	get "/" do
		Ingredient.order("name").to_json  
	end
end