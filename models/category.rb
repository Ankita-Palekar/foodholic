class Category < ActiveRecord::Base
	validates :name, presnece:true, uniqueness: true  
end
