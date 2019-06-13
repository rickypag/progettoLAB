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

  create_table "cronologia", id: false, force: :cascade do |t|
    t.string "document_id", limit: 36, null: false
    t.string "student_id", limit: 20
    t.datetime "timestamp", default: -> { "CURRENT_TIMESTAMP" }, null: false
  end

