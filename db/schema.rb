# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_06_13_192324) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "composes", id: false, force: :cascade do |t|
    t.string "original", limit: 36
    t.integer "ord", limit: 2, null: false
    t.string "page", limit: 36, null: false
  end

  create_table "composition", id: false, force: :cascade do |t|
    t.string "mashup", limit: 36, null: false
    t.integer "ord", limit: 2, null: false
    t.string "page", limit: 36, null: false
    t.float "x"
    t.float "y"
    t.float "h"
    t.float "w"
  end

  create_table "consiglios", force: :cascade do |t|
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_consiglios_on_user_id"
  end

  create_table "creator", id: false, force: :cascade do |t|
    t.string "document_id", limit: 36, null: false
    t.string "student_id", limit: 20
  end

  create_table "documents", primary_key: "document_id", id: :string, limit: 36, force: :cascade do |t|
    t.string "title", limit: 50, null: false
    t.string "student_id", limit: 20, null: false
    t.boolean "flag"
    t.boolean "eliminato"
  end

  create_table "pages", id: false, force: :cascade do |t|
    t.string "page_id", limit: 36, null: false
    t.string "student_id", limit: 20
  end

  create_table "rules", force: :cascade do |t|
    t.string "testo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "student", primary_key: "username", id: :string, limit: 20, force: :cascade do |t|
    t.string "university", limit: 50
    t.string "faculty", limit: 50
    t.string "email", limit: 50
    t.bigint "xp"
    t.string "image"
    t.string "name", limit: 10
    t.string "surname", limit: 20
    t.string "bio"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "consiglios", "users"
end
