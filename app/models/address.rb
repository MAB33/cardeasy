class Address < ActiveRecord::Base
	belongs_to :user
	validates_presence_of :name, :address_line1, :address_city, :address_state, :address_zip, :address_country
	validates_format_of :address_zip, :with => /\A\d{5}(-\d{4})?\Z/, :message => "should be in the form 12345 or 12345-1234"

	before_save :titelize_inputs

	def titelize_inputs
		self.name = self.name.titleize
		self.address_city = self.address_city.titleize
		self.address_line1 = self.address_line1.titleize
	end
end
