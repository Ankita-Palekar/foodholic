class ChangeColumnRecipes < ActiveRecord::Migration
  def change
  	rename_column(:recipes, :methods, :method)
  	change_column(:recipes, :method, :text)
  end
end
