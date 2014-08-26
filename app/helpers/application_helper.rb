module ApplicationHelper
	# finds the address associated with the user via address_id attribute on user
	def user_primary_address
		addresses = Address.all
		addresses.find_by(id: current_user.address_id)
	end

	def current_order
		Order.find_by(status: "in progress", user_id: current_user.id)
	end

	def past_orders
		Order.find_by(status: "ordered", user_id: current_user.id)
	end

	def print_price(price)
		number_to_currency price
	end

	#sets the cardlings delivery date to 10 days prior to recipient's birthday - used by cron task to collect jobs for Lob
	def set_delivery_date(date)
   		delivery_date = (date - 10)
   		delivery_date = delivery_date.change(:year => Date.today.year)
   		if delivery_date < Date.today
   			delivery_date = delivery_date + 1.year
   		else
   			delivery_date
   		end
   		delivery_date
	end

	#collects the all of the current user's addresses
	def user_contacts
		user_addresses = []
		addresses = Address.all
		addresses.each do |address|
			if address.user_id = current_user.id
				user_addresses << address
			end
		end
	end

	#collects the all of the current user's cards
	def user_cards
		user_cards = []
		cards = Card.all
		cards.each do |card|
			if card.user_id = current_user.id
				user_cards << card
			end
		end
	end

	#collects the current user's order history
	def user_orders
		user_orders = []
		orders = Order.all
		orders.each do |order|
			if order.user_id = current_user.id
				user_orders << order
			end
		end
	end

end
