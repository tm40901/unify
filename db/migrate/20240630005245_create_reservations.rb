class CreateReservations < ActiveRecord::Migration[7.0]
  def change
    create_table :reservations do |t|
      t.references :instrument, null: false, foreign_key: true
      t.references :user,       null: false, foreign_key: true
      t.datetime   :start_time, null: false
      t.datetime   :end_time,   null: false
      t.timestamps
    end
  end
end
