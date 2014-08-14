class ChangeAddressCountryColumnName < ActiveRecord::Migration
  def change
  	rename_column :addresses, :address_country, :country
  end
end
