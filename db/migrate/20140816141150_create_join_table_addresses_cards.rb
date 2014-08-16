class CreateJoinTableAddressesCards < ActiveRecord::Migration
  def change
    create_join_table :addresses, :cards do |t|
      # t.index [:address_id, :card_id]
      # t.index [:card_id, :address_id]
    end
  end
end
