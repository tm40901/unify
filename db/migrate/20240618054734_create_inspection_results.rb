class CreateInspectionResults < ActiveRecord::Migration[7.0]
  def change
    create_table :inspection_results do |t|
      t.references :instrument,      null: false, foreign_key: true
      t.references :inspection_item, null: false, foreign_key: true
      t.references :inspector,       null: false, foreign_key: { to_table: :users }
      t.string     :result,          null: false
      t.string     :custom_id,       null: false
      t.string     :status,          null: false
      t.timestamps
    end
  end
end
