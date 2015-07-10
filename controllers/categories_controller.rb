class CategoriesController < ApplicationController
	get '/create' do
		erb :add_category
	end
end