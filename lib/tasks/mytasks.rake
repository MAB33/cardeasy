namespace :mytasks do
	desc "Gathers all cardlings with a delivery_date that matches the current date"
	task collect_cards: :environment do
		cardlings_array = []
		cardlings = Cardling.all
		cardlings.each do |card|
			if card.delivery_date <= Date.today
				cardlings_array << card
			end
		end
		cardlings_array
		puts "*********************#{Time.now} - #{cardlings_array}"
    end

end