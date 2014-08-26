class AddPriceToCardTemplatesTable < ActiveRecord::Migration
  def change
  	add_column :card_templates, :price, :decimal
  end
end
