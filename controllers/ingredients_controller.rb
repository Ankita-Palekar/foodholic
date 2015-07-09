class IngredientsController < ApplicationController
	get "/" do
		Ingredient.select("name").order("name").to_json  
	end
end