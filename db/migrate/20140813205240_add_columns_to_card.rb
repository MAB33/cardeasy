class AddColumnsToCard < ActiveRecord::Migration
  def change
  	add_column :cards, :name, :string
  	add_column :cards, :file, :string
  	add_column :cards, :setting_id, :string
  	add_column :cards, :quantity, :string
  	add_column :cards, :double_sided, :string
  	add_column :cards, :full_bleed, :string
  end
end