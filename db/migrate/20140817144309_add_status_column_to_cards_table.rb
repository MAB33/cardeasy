class AddStatusColumnToCardsTable < ActiveRecord::Migration
  def change
  	add_column :cards, :status, :string
  end
end
