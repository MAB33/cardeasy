class Address < ActiveRecord::Base
	belongs_to :user
	has_and_belongs_to_many :cards
	has_many :cardlings
	validates_presence_of :fname, :lname, :address_line1, :city, :state, :zip, :country, :birthday
	validates_format_of :zip, :with => /\A\d{5}(-\d{4})?\Z/, :message => "should be in the form 12345 or 12345-1234"

	before_save :titelize_inputs, :strip_whitespace

	private

	# def nil_if_blank
	# 	NULL_ATTRS.each { |attr| self[attr] = nil if self[attr].blank? }
	# end

	def titelize_inputs
		self.fname = self.fname.titleize unless self.fname.blank?
		self.lname = self.lname.titleize unless self.lname.blank?
		self.city = self.city.titleize unless self.city.blank?
		self.address_line1 = self.address_line1.titleize unless self.address_line1.blank?
		self.address_line2 = self.address_line2.titleize unless self.address_line2.blank?
	end

	def strip_whitespace
		self.fname = self.fname.strip unless self.fname.blank?
		self.lname = self.lname.strip unless self.lname.blank?
		self.city = self.city.strip unless self.city.blank?
		self.address_line1 = self.address_line1.strip unless self.address_line1.blank?
		self.address_line2 = self.address_line2.strip unless self.address_line2.blank?
		self.zip = self.zip.strip unless self.zip.blank?
	end
	
end
