class CategoriesController < ApplicationController
	get '/create' do
		category = Category.new
		erb :create_category
	end

	post '/create' do
		
	end

end