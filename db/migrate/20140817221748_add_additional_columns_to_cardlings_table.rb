class AddAdditionalColumnsToCardlingsTable < ActiveRecord::Migration
  def change
  	add_column :cardlings, :address_id, :integer
  	add_column :cardlings, :status, :string
  	add_column :cardlings, :delivery_date, :date
  end
end