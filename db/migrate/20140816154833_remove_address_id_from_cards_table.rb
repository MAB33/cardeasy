class RemoveAddressIdFromCardsTable < ActiveRecord::Migration
  def change
  	remove_column :cards, :address_id, :integer
  end
end
