class ChangeJoinTable < ActiveRecord::Migration
  def change
  	rename_column :ingredients_recipes, :recipes_id, :recipe_id
  	rename_column :ingredients_recipes, :ingredients_id, :ingredient_id
  end
end
