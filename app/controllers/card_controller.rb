class CardController < ApplicationController
	before_action :authenticate_user!
	before_action :set_card, only: [:show, :edit, :update, :destroy]

	def index
		@cards = Card.all
		@card_templates = CardTemplate.all
	end

	def new
		@card = Card.new
		@card_templates = CardTemplate.all
	end

	def generate_user_card_for_lob
		### Generates the PDF to be sent to Lob API for print
		@card_templates = CardTemplate.all
		Prawn::Document.generate("public/users_cards/User-#{@card.user_id}_Card-#{@card.id}.pdf", :page_size => [738, 522], :margin => 0) do |pdf|
			pdf.image "public/card_templates/#{@card_templates.find_by(id: @card.card_template_id).template_path}", :position => :center, :width => 738, :height => 522
			pdf.start_new_page
			pdf.font("Times-Roman", :size => 18) do
				pdf.text_box "#{@card.message}",
				:at => [414, 477],
				:height => 432, :width => 279,
				:valign => :center,
				:overflow => :shrink_to_fit,
				:min_font_size => 10,
				:disable_wrap_by_char => true
			end
		end
		### Updates the Card file attribute to the newly generated PDF
		@card.update(file: "/users_cards/User-#{@card.user_id}_Card-#{@card.id}.pdf")
	end

	def create
		@user = User.find(current_user.id)
		@card = Card.new(card_params)
		@card_templates = CardTemplate.all
	  	@card.user = User.find(current_user.id)
	  	
	  	if @card.save
	  		generate_user_card_for_lob
			flash[:notice] = "The card has been added to your collection!"
			redirect_to user_card_path(current_user.id, @card)
	    else 
			flash[:alert] = "There was a problem creating the card. Please try again."
			render :new
	    end

	end

	def show
		@card_templates = CardTemplate.all
	end

	def edit
		@card_templates = CardTemplate.all
	end

	def update
		@card_templates = CardTemplate.all
      if @card.update(card_params)
      	generate_user_card_for_lob
        flash[:notice] = "The card has been updated."
        redirect_to user_card_path(current_user.id, @card)
      else
        flash[:alert] = "There was a problem updating the card. Please try again."
        render :edit
      end
	end

	def destroy
      if @card.delete
        flash[:notice] = "The card has been deleted."
        redirect_to user_card_index_path
      else
        flash[:alert] = "There was a problem deleting the card."
        redirect_to user_card_index_path
      end
	end

	

	private

	def card_params
		params.require(:card).permit(:name, :file, :quantity, :card_template_id, :message, :to_address_id)

	end

	def set_card
		@card = Card.find(params[:id])
	end
end
