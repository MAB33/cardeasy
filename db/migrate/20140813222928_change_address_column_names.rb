class ChangeAddressColumnNames < ActiveRecord::Migration
  def change
  	rename_column :addresses, :address_city, :city
  	rename_column :addresses, :address_state, :state
  	rename_column :addresses, :address_zip, :zip
  end
end
