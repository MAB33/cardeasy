class CardTemplatesController < ApplicationController
  def index
  	@card_templates = CardTemplate.all
  end

  def show
  	@card_template = CardTemplate.find(params[:id])
  end

end
