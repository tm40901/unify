class CreateInstruments < ActiveRecord::Migration[7.0]
  def change
    create_table :instruments do |t|
      t.string     :name,              null: false
      t.references :admin,             null: false, foreign_key: { to_table: :users }
      t.references :inspector,         null: false, foreign_key: { to_table: :users }
      t.string     :management_number, null: false, unique: true
      t.string     :manufacturer
      t.string     :model
      t.string     :serial_number
      t.datetime   :last_inspected_at
      t.timestamps 
    end
  end
end
