class UpdateCol < ActiveRecord::Migration
  def change
  	remove_column :recipies, :mehtod
  	add_column :recipies, :methods ,:string
  end
end
