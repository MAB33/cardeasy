namespace :simplysent do
	desc "Gathers all cardlings with a delivery_date that matches the current date"
	task collect_cards: :environment do
		Lob.api_key = ENV["LOB_TEST_APIKEY"]
		@lob = Lob()

		# look into moving code to Cardling model
		# searches db and collects all cardlings with a delivery date that matches the current date 
		cardlings_array = []
		cardlings = Cardling.all
		cardlings.each do |card|
			if card.delivery_date <= Date.today && card.status = "queued"
				cardlings_array << card
			end
		end

		# creates a Lob job for each cardling and sends to Lob
		cardlings_array.each do |cardling|
			user_address = cardling.card.user.addresses.find_by(id: cardling.card.user.address_id)
			@job = @lob.jobs.create(
			  name: "Order-#{cardling.order.id}_Card-#{cardling.card.id}_Cardling-#{cardling.id}",
			  from: {
			    name:   "#{cardling.card.user.fname} #{cardling.card.user.lname}" ,
			    address_line1: user_address.address_line1,
			    address_line2: user_address.address_line2,
			    city:    user_address.city,
			    state:  user_address.state,
			    country: "US",
			    zip:    user_address.zip
			  },
			  to: {
			    name:    "#{cardling.address.fname} #{cardling.address.lname}",
			    address_line1: cardling.address.address_line1,
			    address_line2: cardling.address.address_line2,
			    city:    cardling.address.city,
			    state:  cardling.address.state,
			    country: "US",
			    zip:    cardling.address.zip
			  },
			  objects: {
			  	name: "Order-#{cardling.order.id}_Card-#{cardling.card.id}_Cardling-#{cardling.id}",
			    file:      cardling.file,
			    setting_id: 203,
			    double_sided: 1,
			    full_bleed: 1
			  })
			cardling.update(status: "processed")
		end
		puts "*********************#{Time.now} - Lob Jobs Sent - #{cardlings_array}"
    end
end
