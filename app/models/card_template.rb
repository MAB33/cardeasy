class CardTemplate < ActiveRecord::Base
	has_many :cards
	has_many :users, through: :cards
end
