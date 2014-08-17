class CreateCardlings < ActiveRecord::Migration
  def change
    create_table :cardlings do |t|
      t.references :card, index: true
      t.string :file
      t.string :name

      t.timestamps
    end
  end
end
