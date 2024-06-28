# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2024_06_18_054734) do
  create_table "inspection_items", charset: "utf8", force: :cascade do |t|
    t.bigint "instrument_id", null: false
    t.string "item", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["instrument_id"], name: "index_inspection_items_on_instrument_id"
  end

  create_table "inspection_results", charset: "utf8", force: :cascade do |t|
    t.bigint "instrument_id", null: false
    t.bigint "inspection_item_id", null: false
    t.bigint "inspector_id", null: false
    t.bigint "approver_id", null: false
    t.string "result", null: false
    t.string "custom_id", null: false
    t.string "status", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["approver_id"], name: "index_inspection_results_on_approver_id"
    t.index ["inspection_item_id"], name: "index_inspection_results_on_inspection_item_id"
    t.index ["inspector_id"], name: "index_inspection_results_on_inspector_id"
    t.index ["instrument_id"], name: "index_inspection_results_on_instrument_id"
  end

  create_table "instruments", charset: "utf8", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "admin_id", null: false
    t.bigint "inspector_id", null: false
    t.string "management_number", null: false
    t.string "manufacturer"
    t.string "model"
    t.string "serial_number"
    t.datetime "last_inspected_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admin_id"], name: "index_instruments_on_admin_id"
    t.index ["inspector_id"], name: "index_instruments_on_inspector_id"
    t.index ["management_number"], name: "index_instruments_on_management_number", unique: true
  end

  create_table "users", charset: "utf8", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "employee_number", null: false
    t.string "last_name", null: false
    t.string "first_name", null: false
    t.string "department", null: false
    t.string "role", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "inspection_items", "instruments"
  add_foreign_key "inspection_results", "inspection_items"
  add_foreign_key "inspection_results", "instruments"
  add_foreign_key "inspection_results", "users", column: "approver_id"
  add_foreign_key "inspection_results", "users", column: "inspector_id"
  add_foreign_key "instruments", "users", column: "admin_id"
  add_foreign_key "instruments", "users", column: "inspector_id"
end
