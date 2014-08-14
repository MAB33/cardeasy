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

	def create
		@user = User.find(current_user.id)
		@card = Card.new(card_params)
		@card_templates = CardTemplate.all
		# @card.setting_id = "203"
		# @card.double_sided = "1"
	  	@card.user = User.find(current_user.id)
	  	
	  	if @card.save
	      flash[:notice] = "The card has been added to your collection!"
	      redirect_to user_card_index_path(current_user)
	    else 
	      flash[:alert] = "There was a problem creating the card. Please try again."
	      render :new
	    end

	end

	def show
	end

	def edit
		@card_templates = CardTemplate.all
	end

	def update
		puts "******************#{params.inspect}"
      if @card.update(card_params)
        flash[:notice] = "The card has been updated."
        redirect_to edit_user_card_path
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

	
	# def index
 #    @invoices = Invoice.all_invoices(current_customer)
	# end

	#   def show
	#     @invoice = Invoice.find(params[:id])
	#     respond_to do |format|
	#       format.html
	#       format.pdf do
	#         pdf = InvoicePdf.new(@invoice, view_context)
	#         send_data pdf.render, filename: 
	#         "invoice_#{@invoice.created_at.strftime("%d/%m/%Y")}.pdf",
	#         type: "application/pdf"
	#       end
	#     end
	#   end
	# end



	# def index
	# 	@cards = card.all
	# end

 #  	def show

	# end

	# def new
	# 	@card = card.new
	# end

	# def create
	# 	@user = User.find(current_user.id)
	# 	@card = Card.new(card_params)
	# 	@card.card_country = "US"
	#   	@card.user = User.find(current_user.id)
	  	
	#   	if @card.save
	#       flash[:notice] = "The card has been added to your card Book!"
	#       redirect_to user_card_index_path(current_user)
	#     else 
	#       flash[:alert] = "There was a problem adding the card. Please try again."
	#       render :new
	#     end

	# end

	# def edit

	# end

	# def update
 #      if @card.update(card_params)
 #        flash[:notice] = "The card has been updated."
 #        redirect_to user_card_index_path(current_user)
 #      else
 #        flash[:alert] = "There was a problem updating the card. Please try again."
 #        render :edit
 #      end
	# end

	# def destroy
 #      if @card.delete
 #        flash[:notice] = "The card has been deleted."
 #        redirect_to user_card_index_path(current_user)
 #      else
 #        flash[:alert] = "There was a problem deleting the card."
 #        redirect_to user_card_index_path(current_user)
 #      end
	# end

	private

	def card_params
		params.require(:card).permit(:name, :file, :quantity, :card_template_id)

	end

	def set_card
		@card = Card.find(params[:id])
	end
end
