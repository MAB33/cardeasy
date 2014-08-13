class AddressController < ApplicationController

	before_action :authenticate_user!
	before_action :set_address, only: [:show, :edit, :update, :destroy]

	def index
		@addresses = Address.all
	end

  	def show

	end

	def new
		@address = Address.new
	end

	def create
		@user = User.find(current_user.id)
		@address = Address.new(address_params)
		@address.address_country = "US"
	  	@address.user = User.find(current_user.id)
	  	
	  	if @address.save
	  		# if the checkbox for primary address is checked, save the address_id on the user
	  		if params[:primary_address] == "1"
	  			@address.user.update(address_id: @address.id)
	  		end
	      flash[:notice] = "The address has been added to your Address Book!"
	      redirect_to user_address_index_path(current_user)
	    else 
	      flash[:alert] = "There was a problem adding the address. Please try again."
	      render :new
	    end

	end

	def edit

	end

	def update
      if @address.update(address_params)
      	if params[:primary_address] == "1"
  			@address.user.update(address_id: @address.id)
  		end
        flash[:notice] = "The address has been updated."
        redirect_to user_address_index_path(current_user)
      else
        flash[:alert] = "There was a problem updating the address. Please try again."
        render :edit
      end
	end

	def destroy
      if @address.delete
        flash[:notice] = "The address has been deleted."
        redirect_to user_address_index_path(current_user)
      else
        flash[:alert] = "There was a problem deleting the address."
        redirect_to user_address_index_path(current_user)
      end
	end

	private

	def address_params
		params.require(:address).permit(:lob_id, :name, :email, :phone, :address_line1, :address_line2, :address_city, :address_state, :address_zip, :address_country, :date_created, :date_modified, :object)
	end

	def set_address
		@address = Address.find(params[:id])
	end

end
