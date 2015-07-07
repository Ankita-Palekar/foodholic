class CreateText < ActiveRecord::Migration
  def change
  	create_table :texts do |t|
  		t.string :texts

  		t.timestamps 
  	end

  end
end
