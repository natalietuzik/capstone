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

ActiveRecord::Schema[8.0].define(version: 2026_02_26_012540) do
  create_table "journal_entries", force: :cascade do |t|
    t.text "body"
    t.datetime "created_at", null: false
    t.date "date", null: false
    t.string "title", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_journal_entries_on_user_id"
  end

  create_table "medication_logs", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.date "date"
    t.integer "medication_id", null: false
    t.text "notes"
    t.boolean "taken", default: false
    t.time "time_taken"
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["medication_id"], name: "index_medication_logs_on_medication_id"
    t.index ["user_id"], name: "index_medication_logs_on_user_id"
  end

  create_table "medications", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "dosage"
    t.text "instructions"
    t.string "name"
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_medications_on_user_id"
  end

  create_table "mental_health_entries", force: :cascade do |t|
    t.integer "anxiety"
    t.datetime "created_at", null: false
    t.date "date"
    t.text "journal"
    t.integer "mood"
    t.decimal "sleep_hours"
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["user_id", "date"], name: "index_mental_health_entries_on_user_id_and_date", unique: true
    t.index ["user_id"], name: "index_mental_health_entries_on_user_id"
  end

  create_table "planner_items", force: :cascade do |t|
    t.boolean "completed", default: false
    t.datetime "created_at", null: false
    t.date "date"
    t.text "notes"
    t.time "time_of_day"
    t.string "title"
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_planner_items_on_user_id"
  end

  create_table "todo_items", force: :cascade do |t|
    t.boolean "completed", default: false, null: false
    t.datetime "created_at", null: false
    t.text "notes"
    t.integer "priority", default: 2, null: false
    t.string "title", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_todo_items_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email"
    t.string "password_digest"
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "journal_entries", "users"
  add_foreign_key "medication_logs", "medications"
  add_foreign_key "medication_logs", "users"
  add_foreign_key "medications", "users"
  add_foreign_key "mental_health_entries", "users"
  add_foreign_key "planner_items", "users"
  add_foreign_key "todo_items", "users"
end
