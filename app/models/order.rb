class Order < ActiveRecord::Base
	has_many :cardlings
	belongs_to :user
	has_many :cards
	has_many :addresses, through: :cards
end
