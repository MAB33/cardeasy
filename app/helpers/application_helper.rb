module ApplicationHelper
	### finds the address associated with the user via address_id attribute on user
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

end
