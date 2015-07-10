class Recipe < ActiveRecord::Base
	has_many :ratings
	belongs_to :user
	has_and_belongs_to_many :ingredients

	validates :title, presence: true
	validates :user_id, presence: true
	validates :method, presence: true
end