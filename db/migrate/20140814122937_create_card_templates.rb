class CreateCardTemplates < ActiveRecord::Migration
  def change
    create_table :card_templates do |t|
      t.string :template_path
      t.string :thumb_path
      t.string :name

      t.timestamps
    end
  end
end
