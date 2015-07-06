class CreateRatings < ActiveRecord::Migration
  def change
  	create_table	:ratings do |t|
  		t.belongs_to :user, index:true
  		t.belongs_to	:recipie, index:true

  		t.timestamps
  	end
  end
end
