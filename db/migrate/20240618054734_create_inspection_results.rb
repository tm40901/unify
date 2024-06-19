class CreateInspectionResults < ActiveRecord::Migration[7.0]
  def change
    create_table :inspection_results do |t|
      t.references :instrument,      null: false, foreign_key: true
      t.string     :result,          null: false
      t.text       :remarks
      t.timestamps
    end
  end
end
