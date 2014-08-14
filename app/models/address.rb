class Address < ActiveRecord::Base
	belongs_to :user
	validates_presence_of :name, :address_line1, :city, :state, :zip, :country
	validates_format_of :zip, :with => /\A\d{5}(-\d{4})?\Z/, :message => "should be in the form 12345 or 12345-1234"

	before_save :titelize_inputs

	def titelize_inputs
		self.name = self.name.titleize
		self.city = self.city.titleize
		self.address_line1 = self.address_line1.titleize
	end
	
end
