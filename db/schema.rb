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

ActiveRecord::Schema.define(version: 2019_06_07_082417) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "composes", primary_key: "page", id: :string, limit: 36, force: :cascade do |t|
    t.string "original", limit: 36
    t.serial "ord", limit: 2, null: false
    t.index ["original", "ord"], name: "composes_original_ord_key", unique: true
  end

  create_table "composition", primary_key: ["mashup", "ord"], force: :cascade do |t|
    t.string "mashup", limit: 36, null: false
    t.serial "ord", limit: 2, null: false
    t.string "page", limit: 36, null: false
    t.float "x"
    t.float "y"
    t.float "h"
    t.float "w"
  end

  create_table "creator", primary_key: "document", id: :string, limit: 36, force: :cascade do |t|
    t.string "student", limit: 20
  end

  create_table "deletes", force: :cascade do |t|
    t.string "student_id"
    t.string "document_id", limit: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "document", primary_key: "uuid", id: :string, limit: 36, force: :cascade do |t|
    t.string "title", limit: 50, null: false
    t.string "creator", limit: 20, null: false
    t.boolean "flag"
    t.string "ltitle"
  end

  create_table "favourite", primary_key: ["student_id", "document_id"], force: :cascade do |t|
    t.string "student_id", limit: 20, null: false
    t.string "document_id", limit: 36, null: false
  end

  create_table "feedback", primary_key: ["feed", "username"], force: :cascade do |t|
    t.string "username", null: false
    t.string "feed", null: false
  end

  create_table "likes", id: false, force: :cascade do |t|
    t.string "document_id", limit: 36, null: false
    t.string "student_id", limit: 20, null: false
    t.boolean "val", null: false
  end

  create_table "page", id: :string, limit: 36, force: :cascade do |t|
    t.string "owner", limit: 20
  end

  create_table "rating", primary_key: ["document", "student"], force: :cascade do |t|
    t.string "document", limit: 36, null: false
    t.string "student", limit: 20, null: false
    t.integer "val", limit: 2, null: false
  end

  create_table "student", primary_key: "username", id: :string, limit: 20, force: :cascade do |t|
    t.string "university", limit: 50
    t.string "faculty", limit: 50
    t.bigint "xp"
    t.string "image"
    t.string "name", limit: 10
    t.string "surname", limit: 20
    t.string "bio"
    t.string "email"
    t.index ["username"], name: "index_student_on_username", unique: true
    t.index ["username"], name: "student_username_key", unique: true
  end

  create_table "tag", primary_key: ["document", "name"], force: :cascade do |t|
    t.string "document", limit: 36, null: false
    t.string "name", limit: 30, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "provider"
    t.string "uid"
    t.integer "role"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "composes", "document", column: "original", primary_key: "uuid", name: "composes_original_fkey"
  add_foreign_key "composes", "page", column: "page", name: "composes_page_fkey"
  add_foreign_key "composition", "document", column: "mashup", primary_key: "uuid", name: "composition_mashup_fkey"
  add_foreign_key "composition", "page", column: "page", name: "composition_page_fkey"
  add_foreign_key "creator", "document", column: "document", primary_key: "uuid", name: "creator_document_fkey"
  add_foreign_key "creator", "student", column: "student", primary_key: "username", name: "creator_student_fkey"
  add_foreign_key "deletes", "document", primary_key: "uuid"
  add_foreign_key "deletes", "student", primary_key: "username"
  add_foreign_key "document", "student", column: "creator", primary_key: "username", name: "document_creator_fkey"
  add_foreign_key "likes", "document", primary_key: "uuid", name: "likes_document_id_fkey"
  add_foreign_key "likes", "student", primary_key: "username", name: "likes_student_id_fkey"
  add_foreign_key "page", "student", column: "owner", primary_key: "username", name: "page_owner_fkey"
  add_foreign_key "rating", "document", column: "document", primary_key: "uuid", name: "rating_document_fkey"
  add_foreign_key "rating", "student", column: "student", primary_key: "username", name: "rating_student_fkey"
  add_foreign_key "tag", "document", column: "document", primary_key: "uuid", name: "tag_document_fkey"
end
