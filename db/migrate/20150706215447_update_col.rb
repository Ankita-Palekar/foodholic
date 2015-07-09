class UpdateCol < ActiveRecord::Migration
  def change
  	remove_column :recipes, :mehtod
  	add_column :recipes, :methods ,:string
  end
end
