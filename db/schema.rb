# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20141204134111) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "cards", force: true do |t|
    t.integer "rate"
    t.integer "suit"
  end

  create_table "tables", id: :uuid, default: "uuid_generate_v4()", force: true do |t|
    t.string   "stack_user"
    t.string   "stack_dealer"
    t.string   "stack_turn"
    t.boolean  "finished",     default: false, null: false
    t.integer  "winner",       default: 0,     null: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "turns", force: true do |t|
    t.uuid     "table_id"
    t.integer  "card_dealer_id"
    t.integer  "card_user_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "turns", ["table_id", "created_at"], name: "index_turns_on_table_id_and_created_at", using: :btree
  add_index "turns", ["table_id"], name: "index_turns_on_table_id", using: :btree

  add_foreign_key "turns", "tables"
end
