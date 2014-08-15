class Card < ActiveRecord::Base
	belongs_to :user
	belongs_to :card_template

	validates_presence_of :card_template_id, :name, :message
	# validates_uniqueness_of :name
	validates_length_of :message, :maximum => 2245, :message => "is too long"


	before_save :set_up_card_before_save, :strip_whitespace

	private

	def set_up_card_before_save
		self.setting_id = "203"
		self.double_sided = "1"
		self.full_bleed = "1"
		self.quantity = "1"
	end

	def strip_whitespace
		self.name = self.name.strip unless self.name.blank?
	end

end
