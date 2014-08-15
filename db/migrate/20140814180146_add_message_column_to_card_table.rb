class AddMessageColumnToCardTable < ActiveRecord::Migration
  def change
  	add_column :cards, :message, :text
  end
end
