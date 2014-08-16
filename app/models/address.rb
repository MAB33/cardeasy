class Address < ActiveRecord::Base
	belongs_to :user
	has_many :cards
	validates_presence_of :name, :address_line1, :city, :state, :zip, :country
	validates_format_of :zip, :with => /\A\d{5}(-\d{4})?\Z/, :message => "should be in the form 12345 or 12345-1234"

	before_save :titelize_inputs, :strip_whitespace

	private

	# def nil_if_blank
	# 	NULL_ATTRS.each { |attr| self[attr] = nil if self[attr].blank? }
	# end

	def titelize_inputs
		self.name = self.name.titleize unless self.name.blank?
		self.city = self.city.titleize unless self.city.blank?
		self.address_line1 = self.address_line1.titleize unless self.address_line1.blank?
		self.address_line2 = self.address_line2.titleize unless self.address_line2.blank?
	end

	def strip_whitespace
		self.name = self.name.strip unless self.name.blank?
		self.city = self.city.strip unless self.city.blank?
		self.address_line1 = self.address_line1.strip unless self.address_line1.blank?
		self.address_line2 = self.address_line2.strip unless self.address_line2.blank?
		self.zip = self.zip.strip unless self.zip.blank?
	end
	
end
