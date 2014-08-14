class AddCardTemplateIdToCardTableChangeIdColumnsToInteger < ActiveRecord::Migration
  def change
  	add_column :cards, :card_template_id, :integer
  	change_column :cards, :user_id, :integer
  	change_column :addresses, :user_id, :integer
  	change_column :users, :address_id, :integer
  end
end
