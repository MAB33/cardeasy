class AddOrderIdToCardlingsTable < ActiveRecord::Migration
  def change
  	add_column :cardlings, :order_id, :integer
  end
end
