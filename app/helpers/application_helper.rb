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

end
