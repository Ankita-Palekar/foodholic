 class Ingredient < ActiveRecord::Base
	has_and_belongs_to_many :recipes
	validates :name, :presence	=>	true, :uniqueness	=>	true


	def ingredient_error_message
		self.errors.full_mesages
	end
end