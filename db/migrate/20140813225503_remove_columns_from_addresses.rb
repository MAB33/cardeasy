class RemoveColumnsFromAddresses < ActiveRecord::Migration
  def change
  	remove_column :addresses, :date_created
  	remove_column :addresses, :date_modified
  end
end
