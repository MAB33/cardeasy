class ChangeNameToFnameAddLnameToAddressesTable < ActiveRecord::Migration
  def change
  	add_column :addresses, :lname, :string
  	rename_column :addresses, :name, :fname
  end
end
