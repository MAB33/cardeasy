class OrdersController < ApplicationController
	
	before_action :authenticate_user!
	before_action :current_order, only: [:show, :add_to_cart, :remove_from_cart]

	def index
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
        	redirect_to root_path
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

	def set_delivery_date(date)
   		delivery_date = (date - 10)
   		delivery_date = delivery_date.change(:year => Time.now.year)
   		if delivery_date >= Time.now
   			delivery_date
   		else
   			delivery_date = delivery_date.change(:year => Time.now.year) + 1.year
   		end
   		delivery_date
	end

	def checkout
		current_order.cards.each do |card|
			card.addresses.each do |address|
				generate_card_pdf_for_lob(card, address)
				@cardling = Cardling.create(file: "User-#{card.user_id}_Order-#{current_order.id}_Address-#{address.id}.pdf", card_id: card.id, order_id: current_order.id, delivery_date: set_delivery_date(address.birthday), status: "queued", address_id: address.id)
			end
			if @cardling.save
				card.update(status: "ordered")
			else
				flash[:notice] = "There was a problem completing your order. Please try again."
				redirect_to user_order_path(id: current_order.id, user_id: current_user.id)
			end
		end
		current_order.update(status: "ordered")
		send_card_to_lob
		flash[:notice] = "Your order has been placed!"
		redirect_to root_path
	end

	def generate_card_pdf_for_lob(card, address)
		Prawn::Document.generate("public/users_cards/User-#{card.user_id}_Order-#{current_order.id}_Address-#{address.id}.pdf", :page_size => [738, 522], :margin => 0) do |pdf|
			pdf.image "public/card_templates/#{card.card_template.template_path}", :position => :center, :width => 738, :height => 522
			pdf.start_new_page
			pdf.font("public/fonts/LaBelleAurore.ttf", :size => 16) do
				pdf.text_box "Dear #{address.fname}, \n\n #{card.message}",
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

	def send_jobs_to_lob
		Lob.api_key = ENV["LOB_TEST_APIKEY"]
		@lob = Lob()

		cardling = Cardling.last
		user_address = cardling.card.user.addresses.find_by(id: cardling.card.user.address_id)

		@job = @lob.jobs.create(
		  name: "Order-#{cardling.order.id}_Card-#{cardling.card.id}",
		  from: {
		    name:   "#{cardling.card.user.fname} #{cardling.card.user.lname}" ,
		    address_line1: user_address.address_line1,
		    address_line2: user_address.address_line2,
		    city:    user_address.city,
		    state:  user_address.state,
		    country: "US",
		    zip:    user_address.zip
		  },
		  to: {
		    name:    "#{cardling.address.fname} #{cardling.address.lname}",
		    address_line1: cardling.address.address_line1,
		    address_line2: cardling.address.address_line2,
		    city:    cardling.address.city,
		    state:  cardling.address.state,
		    country: "US",
		    zip:    cardling.address.zip
		  },
		  objects: {
		    file:      "https://s3.amazonaws.com/card_bucket/User-2_Order-64_Address-18.pdf",
		    setting_id: 203,
		    double_sided: 1,
		    full_bleed: 1
		  })
		puts @job
	end

	private

	def current_order
		Order.find_by(status: "in progress", user_id: current_user.id)
	end

end
