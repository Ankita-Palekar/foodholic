class AddAdminRole < ActiveRecord::Migration
  def change
  	create_table :categories do |t|
  		t.string :name
  	end

		add_column :users, :admin, :string, default:false
  end
end
