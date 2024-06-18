class CreateInspectionItems < ActiveRecord::Migration[7.0]
  def change
    create_table :inspection_items do |t|
      t.references :instrument, null: false, foreign_key: true
      t.string     :item,       null: false
      t.timestamps
    end
  end
end
