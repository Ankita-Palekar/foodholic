class Category < ActiveRecord::Base
	has_many :subcategories 	
	validates :name, presnece:true, uniqueness: true  
end
