class Card < ActiveRecord::Base
	belongs_to :user
	belongs_to :card_template

	validates_presence_of :card_template_id, :name
	validates_uniqueness_of :name

	before_save :set_up_card_before_save

	def set_up_card_before_save
		self.setting_id = "203"
		self.double_sided = "1"
	end

end
