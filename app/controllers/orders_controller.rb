class OrdersController < ApplicationController
	
	before_action :authenticate_user!
	before_action :current_order, only: [:show, :add_to_cart, :remove_from_cart]

	def new
	end

  	def show
		@cards = Card.all.find_by(order_id: @order)
	end

	def add_to_cart
		puts "PARAMS#{params.inspect}"
		@card = Card.find(params[:card_id])
		@user = User.find(current_user.id)

		if @card.status == "ordered"
			flash[:notice] = "This card has already been ordered!"
        	redirect_to user_order_path(id: current_order.id, user_id: current_user.id)
		elsif @card.status == "in cart"
			flash[:notice] = "This card is already in your cart!"
        	redirect_to user_order_path(id: current_order.id, user_id: current_user.id)
		elsif @card.status == "draft"
			if current_order
				@card.update(order_id: current_order.id, status: "in cart")
				flash[:notice] = "Card has been your cart!"
			else
			    @order = Order.create(user_id: @user.id, status: "in progress")
			    @card.update(order_id: current_order.id, status: "in cart")
			    flash[:notice] = "Card has been your cart!"
		   	end
		   	redirect_to user_card_path(id: @card.id, user_id: current_user.id)
		end
	end

	def remove_from_cart
		@card = Card.find(params[:card_id])
		if @card.update(order_id: nil, status: "draft")
			flash[:notice] = "Card has been removed from cart."
			if current_order.cards.blank?
				current_order.delete
				redirect_to empty_cart_path
			else
				redirect_to user_order_path(id: current_order.id, user_id: current_user.id)
			end
		else
			flash[:notice] = "There was a problem removing this card. Please try again."
			redirect_to user_order_path(id: current_order.id, user_id: current_user.id)
		end
	end

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

	private

	def current_order
		Order.find_by(status: "in progress", user_id: current_user.id)
	end

end
