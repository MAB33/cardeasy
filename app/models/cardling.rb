class Cardling < ActiveRecord::Base
  belongs_to :card
  belongs_to :order
  belongs_to :address
  #belongs_to :user, through: :cards

	def collect_cardlings_for_lob
		cardlings_array = []
		cardlings = Cardling.all
		cardlings.each do |card|
			if card.delivery_date <= Date.today
				cardlings_array << card
			end
		end
		cardlings_array
	end

end
