class ChnageRecipeRecipe < ActiveRecord::Migration
  def change
  	rename_table :recipes, :recipes
  	rename_column :ratings, :recipe_id, :recipe_id
  	remove_column :recipes, :ingredients 
  end
end
