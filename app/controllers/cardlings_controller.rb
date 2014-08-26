class CardlingsController < ApplicationController

	before_action :authenticate_user!
	before_action :set_cardling, only: [:show, :edit, :update, :destroy, :generate_user_card_for_lob]

	def destroy
      if @cardling.delete
        flash[:notice] = "The card has been canceled."
        # if ALL cardlings associated with an order have been deleted, the order is also deleted
        if @cardling.order.cardlings.blank?
				@cardling.order.delete
				redirect_to profile_path
			else
				redirect_to profile_path
			end
      else
        flash[:alert] = "There was a problem canceling the card."
        redirect_to profile_path
      end
	end

	private
	def set_cardling
		@cardling = Cardling.find(params[:id])
	end
end
