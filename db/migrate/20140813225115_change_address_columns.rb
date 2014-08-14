class ChangeAddressColumns < ActiveRecord::Migration
  def change
  	rename_column :addresses, :string, :city
  	add_column :addresses, :state, :string
  	add_column :addresses, :zip, :string
  	add_column :addresses, :country, :string
  end
end
