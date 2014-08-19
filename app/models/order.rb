class Order < ActiveRecord::Base
	has_many :cardlings
	belongs_to :user
	has_many :cards
	has_many :addresses, through: :cards

	# def send_cards_to_lob_test
	# # Lob.api_key = "LOB_TEST_APIKEY"
	# 	# @lob = Lob.load
	# 	Lob.api_key = ENV["LOB_TEST_APIKEY"]
	# 	@lob = Lob()

	# 	cardling = Cardling.last
	# 	user_address = cardling.card.user.addresses.find_by(id: cardling.card.user.address_id)

	# 	@job = @lob.jobs.create(
	# 	  name: "Order-#{cardling.order.id}_Card-#{cardling.card.id}",
	# 	  from: {
	# 	    name:   "#{cardling.card.user.fname} #{cardling.card.user.lname}" ,
	# 	    address_line1: user_address.address_line1,
	# 	    address_line2: user_address.address_line2,
	# 	    city:    user_address.city,
	# 	    state:  user_address.state,
	# 	    country: "US",
	# 	    zip:    user_address.zip
	# 	  },
	# 	  to: {
	# 	    name:    "#{cardling.address.fname} #{cardling.address.lname}",
	# 	    address_line1: cardling.address.address_line1,
	# 	    address_line2: cardling.address.address_line2,
	# 	    city:    cardling.address.city,
	# 	    state:  cardling.address.state,
	# 	    country: "US",
	# 	    zip:    cardling.address.zip
	# 	  },
	# 	  objects: {
	# 	    file:      "https://s3.amazonaws.com/card_bucket/User-2_Order-64_Address-18.pdf",
	# 	    setting_id: 203,
	# 	    double_sided: 1,
	# 	    full_bleed: 1
	# 	  })
	# 	puts @job
	# end
end
