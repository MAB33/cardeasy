module ApplicationHelper
	### finds the address associated with the user via address_id attribute on user
	def user_primary_address
		addresses = Address.all
		addresses.find_by(id: current_user.address_id)
	end

end
