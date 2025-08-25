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

ActiveRecord::Schema[8.0].define(version: 2025_07_08_120730) do
  create_table "assets", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "name", limit: 63, null: false
    t.string "memo", limit: 63
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_assets_on_name", unique: true
  end

  create_table "charges", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.integer "amount", null: false, unsigned: true
    t.date "date", null: false
    t.string "memo", limit: 63
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "debt_id", null: false
    t.bigint "recipient_id"
    t.index ["debt_id"], name: "index_charges_on_debt_id"
    t.index ["recipient_id"], name: "index_charges_on_recipient_id"
  end

  create_table "debts", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "name", limit: 63, null: false
    t.string "memo", limit: 63
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_debts_on_name", unique: true
  end

  create_table "discharges", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.integer "amount", null: false, unsigned: true
    t.date "date", null: false
    t.string "memo", limit: 63
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "debt_id", null: false
    t.bigint "recipient_id"
    t.index ["debt_id"], name: "index_discharges_on_debt_id"
    t.index ["recipient_id"], name: "index_discharges_on_recipient_id"
  end

  create_table "incomes", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.integer "amount", null: false, unsigned: true
    t.date "date", null: false
    t.string "memo", limit: 63
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "asset_id", null: false
    t.bigint "recipient_id"
    t.index ["asset_id"], name: "index_incomes_on_asset_id"
    t.index ["recipient_id"], name: "index_incomes_on_recipient_id"
  end

  create_table "outgoes", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.integer "amount", null: false, unsigned: true
    t.date "date", null: false
    t.string "memo", limit: 63
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "asset_id", null: false
    t.bigint "recipient_id"
    t.index ["asset_id"], name: "index_outgoes_on_asset_id"
    t.index ["recipient_id"], name: "index_outgoes_on_recipient_id"
  end

  create_table "recipients", charset: "utf8mb4", collation: "utf8mb4_uca1400_ai_ci", force: :cascade do |t|
    t.string "name", limit: 63, null: false
    t.string "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_recipients_on_name", unique: true
  end

  add_foreign_key "charges", "debts"
  add_foreign_key "charges", "recipients"
  add_foreign_key "discharges", "debts"
  add_foreign_key "discharges", "recipients"
  add_foreign_key "incomes", "assets"
  add_foreign_key "incomes", "recipients"
  add_foreign_key "outgoes", "assets"
  add_foreign_key "outgoes", "recipients"
end
