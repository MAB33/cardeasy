class CardsController < ApplicationController
	before_action :authenticate_user!
	before_action :set_card, only: [:show, :edit, :update, :destroy, :generate_user_card_for_lob]

	def index
		@orders = Order.all
		@cards = Card.all
		@card_templates = CardTemplate.all
	end

	def new
		@card = Card.new
		@card_templates = CardTemplate.all
	end

	# def generate_user_card_for_lob
	# 	### Generates the PDF to be sent to Lob API for print
	# 	@card_templates = CardTemplate.all
	# 	Prawn::Document.generate("public/users_cards/User-#{@card.user_id}_Card-#{@card.id}.pdf", :page_size => [738, 522], :margin => 0) do |pdf|
	# 		pdf.image "public/card_templates/#{@card_templates.find_by(id: @card.card_template_id).template_path}", :position => :center, :width => 738, :height => 522
	# 		pdf.start_new_page
	# 		pdf.font("Times-Roman", :size => 18) do
	# 			# pdf.text "#{@card.id}",
	# 			pdf.text_box "#{@card.id} \n\n #{@card.message}",
	# 			:at => [414, 477],
	# 			:height => 432, :width => 279,
	# 			:valign => :center,
	# 			:overflow => :shrink_to_fit,
	# 			:min_font_size => 10,
	# 			:disable_wrap_by_char => true
	# 		end
	# 	end
	# 	### Updates the Card file attribute to the newly generated PDF
	# 	@card.update(file: "/users_cards/User-#{@card.user_id}_Card-#{@card.id}.pdf")
	# end

	def generate_user_card_for_lob
		### Generates the PDF to be sent to Lob API for print
		@card_templates = CardTemplate.all

		@card.addresses.each do |address|
			Prawn::Document.generate("public/users_cards/User-#{@card.user_id}_Card-#{@card.id}_Address-#{address.id}.pdf", :page_size => [738, 522], :margin => 0) do |pdf|
			pdf.image "public/card_templates/#{@card.card_template.template_path}", :position => :center, :width => 738, :height => 522
			pdf.start_new_page
			pdf.font("public/fonts/LaBelleAurore.ttf", :size => 16) do
				pdf.text_box "Dear #{address.fname}, \n\n #{@card.message}",
				:leading => -4,
				:at => [414, 477],
				:height => 432, :width => 279,
				:valign => :center,
				:overflow => :shrink_to_fit,
				:min_font_size => 9,
				:disable_wrap_by_char => true
			end
		end
		end
		### Updates the Card file attribute to the newly generated PDF
		# @card.update(file: "/users_cards/User-#{@card.user_id}_Card-#{@card.id}.pdf")
	end

	def create
		@user = User.find(current_user.id)
		@card = Card.new(card_params)
		@card_templates = CardTemplate.all
	  	@card.user = User.find(current_user.id)
	  	@card.setting_id = "203"
		@card.double_sided = "1"
		@card.full_bleed = "1"
		@card.quantity = "1"
		@card.status = "draft"
		@card.price = 1.85
	  	
	  	if @card.save
	  		# generate_user_card_for_lob
			flash[:notice] = "The card has been added to your collection!"
			redirect_to user_card_path(current_user, @card)
	    else 
			flash[:alert] = "There was a problem creating the card. Please try again."
			render :new
	    end

	end

	def show
		@orders = Order.all
		@card_templates = CardTemplate.all
	end

	def edit
		@card_templates = CardTemplate.all
	end

	def update
		params[:card][:address_ids] ||= []
		@card_templates = CardTemplate.all
      if @card.update(card_params)
      	# generate_user_card_for_lob
        flash[:notice] = "The card has been updated."
        redirect_to user_card_path
      else
        flash[:alert] = "There was a problem updating the card. Please try again."
        render :edit
      end
	end

	def destroy
		current_order = Order.find_by(status: "in progress", user_id: current_user.id)
      if @card.delete
      	if current_order.cards.blank?
			current_order.delete
		end
        flash[:notice] = "The card has been deleted."
        redirect_to user_cards_path
      else
        flash[:alert] = "There was a problem deleting the card."
        redirect_to user_cards_path
      end
	end

	

	private

	def card_params
		params.require(:card).permit(:name, :file, :quantity, :card_template_id, :message, :address_ids => [])

	end

	def set_card
		@card = Card.find(params[:id])
	end
end
