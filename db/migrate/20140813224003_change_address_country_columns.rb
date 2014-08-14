class ChangeAddressCountryColumns < ActiveRecord::Migration
  def change
  	rename_column :addresses, :city, :string
  	rename_column :addresses, :state, :string
  	rename_column :addresses, :zip, :string
  	rename_column :addresses, :country, :string
  end
end
