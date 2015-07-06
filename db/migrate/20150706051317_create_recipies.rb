class CreateRecipies < ActiveRecord::Migration
  def change
  	create_table :recipies do |t|
  		t.belongs_to 	:user, index:true
  		t.string			:title
  		t.text				:ingredients
  		t.text				:mehtod

  		t.timestamps
  	end
  end
end
