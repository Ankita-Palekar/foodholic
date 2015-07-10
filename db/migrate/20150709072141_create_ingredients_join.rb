class CreateIngredientsJoin < ActiveRecord::Migration
  def change
  	create_table :ingredients do |t|
  		t.string :name
  	end
  	create_table :ingredients_recipes do |t|
  		t.belongs_to :recipes,  index: true
  		t.belongs_to :ingredients, index: true
  	end
  end
end
