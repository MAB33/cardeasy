class ChangeToAddressIdNameCardsTable < ActiveRecord::Migration
  def change
  	rename_column :cards, :to_address_id, :address_id
  end
end
