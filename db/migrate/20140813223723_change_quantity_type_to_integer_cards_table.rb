class ChangeQuantityTypeToIntegerCardsTable < ActiveRecord::Migration
  def change
  	change_column :cards, :quantity, :integer
  end
end
