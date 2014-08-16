class AddBirthdayColumnToAddressTable < ActiveRecord::Migration
  def change
  	add_column :addresses, :birthday, :date
  end
end
