class CardlingsController < ApplicationController

	before_action :authenticate_user!
	before_action :set_cardling, only: [:show, :edit, :update, :destroy, :generate_user_card_for_lob]

	def destroy
      if @cardling.delete
        flash[:notice] = "The card has been deleted."
        redirect_to user_cards_path
      else
        flash[:alert] = "There was a problem deleting the card."
        redirect_to user_cards_path
      end
	end

	private
	def set_cardling
		@cardling = Cardling.find(params[:id])
	end
end
