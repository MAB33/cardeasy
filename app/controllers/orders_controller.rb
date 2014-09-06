class OrdersController < ApplicationController
	
	before_action :authenticate_user!
	before_action :current_order, only: [:show, :add_to_cart, :remove_from_cart]

	def index
	end

  	def show
		@cards = Card.all.find_by(order_id: @order)
	end

	def add_to_cart
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
				# flash[:notice] = "Card has been added to your cart!"
			else
			    @order = Order.create(user_id: @user.id, status: "in progress")
			    @card.update(order_id: current_order.id, status: "in cart")
			    # flash[:notice] = "Card has been added to your cart!"
		   	end
		   	redirect_to user_card_path(id: @card.id, user_id: current_user.id)
		end
	end

	def remove_from_cart
		@card = Card.find(params[:card_id])
		if @card.update(order_id: nil, status: "draft")
			# flash[:notice] = "Card has been removed from cart."
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

	# calculates the delivery date of a card to be 10 days prior to the saved address's/contact'c birthday
	# if the card is created with less than ten days to the birthday, sets the deliveray date for the next year
	# used by cron task to pick up cardlings that need to be sent to Lob
	def set_delivery_date(date)
   		delivery_date = (date - 10)
   		delivery_date = delivery_date.change(:year => Date.today.year)
   		if delivery_date < Date.today
   			delivery_date = delivery_date + 1.year
   		else
   			delivery_date
   		end
   		delivery_date
	end

	def checkout
		current_order.cards.each do |card|
			# create a Cardling for each address/contact associated with the Card
			card.addresses.each do |address|
				generate_card_pdf_for_lob(card, address)
				@cardling = Cardling.create(file: "https://s3.amazonaws.com/card-bucket/User-#{card.user_id}_Order-#{current_order.id}_Address-#{address.id}.pdf", card_id: card.id, order_id: current_order.id, delivery_date: set_delivery_date(address.birthday), status: "queued", address_id: address.id)
			end
			if @cardling.save
				card.update(status: "ordered")
			else
				flash[:notice] = "There was a problem completing your order. Please try again."
				redirect_to user_order_path(id: current_order.id, user_id: current_user.id)
			end
		end
		current_order.update(status: "ordered")
		flash[:notice] = "Your order has been placed!"
		redirect_to root_path
	end

	# saves a copy of the cardling PDF to Amazon S3 bucket
	# path and name are created in generate_card_pdf_for_lob method
	def save_pdf_to_s3(path, name)
		AWS.config( :access_key_id => ENV['AWS_ACCESS_KEY_ID'], :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY'])
		s3 = AWS::S3.new
		bucket = s3.buckets['card-bucket']
		obj = s3.buckets['card-bucket'].objects[name] 
		obj.write(file: path)
		puts "********** s3 success! **********"
	end

	# card and address are taken in at checkout
	# uses Prawn gem to generate PDF and saves it in my app
	def generate_card_pdf_for_lob(card, address)
		name = "User-#{card.user_id}_Order-#{current_order.id}_Address-#{address.id}.pdf"
		path = "public/users_cards/#{name}"
		Prawn::Document.generate(path, :page_size => [738, 522], :margin => 0) do |pdf|
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
		puts "************* prawn success ************"
		save_pdf_to_s3(path, name)
	end

	private

	def current_order
		Order.find_by(status: "in progress", user_id: current_user.id)
	end

end
