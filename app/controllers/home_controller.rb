class HomeController < ApplicationController
	def index
		@card_templates = CardTemplate.all
	end
end
