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

ActiveRecord::Schema[8.1].define(version: 2026_07_11_080600) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "families", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "invite_code"
    t.string "name"
    t.datetime "updated_at", null: false
  end

  create_table "family_members", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "family_id", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["family_id"], name: "index_family_members_on_family_id"
    t.index ["user_id"], name: "index_family_members_on_user_id"
  end

  create_table "task_categories", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.datetime "updated_at", null: false
  end

  create_table "task_logs", force: :cascade do |t|
    t.datetime "completed_at"
    t.datetime "created_at", null: false
    t.bigint "family_member_id", null: false
    t.bigint "task_id", null: false
    t.datetime "updated_at", null: false
    t.index ["family_member_id"], name: "index_task_logs_on_family_member_id"
    t.index ["task_id"], name: "index_task_logs_on_task_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.bigint "task_category_id", null: false
    t.datetime "updated_at", null: false
    t.index ["task_category_id"], name: "index_tasks_on_task_category_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "character"
    t.datetime "created_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.bigint "family_id"
    t.string "name"
    t.string "nickname"
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["family_id"], name: "index_users_on_family_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "family_members", "families"
  add_foreign_key "family_members", "users"
  add_foreign_key "task_logs", "family_members"
  add_foreign_key "task_logs", "tasks"
  add_foreign_key "tasks", "task_categories"
  add_foreign_key "users", "families"
end
