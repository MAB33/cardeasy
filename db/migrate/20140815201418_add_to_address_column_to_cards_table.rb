class AddToAddressColumnToCardsTable < ActiveRecord::Migration
  def change
  	add_column :cards, :to_address_id, :integer
  end
end
