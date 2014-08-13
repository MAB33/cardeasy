class ChangeAddressColumnNameInUserTable < ActiveRecord::Migration
  def change
  	rename_column :users, :address, :address_id
  end
end
