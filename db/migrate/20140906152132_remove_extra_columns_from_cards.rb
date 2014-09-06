class RemoveExtraColumnsFromCards < ActiveRecord::Migration
  def change
    remove_column :cards, :setting_id, :string
    remove_column :cards, :double_sided, :string
    remove_column :cards, :full_bleed, :string
    remove_column :cards, :price, :decimal
    remove_column :cards, :file, :string
  end
end
