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

ActiveRecord::Schema.define(version: 20160707020052) do

  create_table "aliases", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "avengers", force: :cascade do |t|
    t.string   "name"
    t.integer  "appearances"
    t.boolean  "current"
    t.string   "gender"
    t.boolean  "honorary"
    t.text     "notes"
    t.boolean  "alive",        default: true
    t.integer  "died_times",   default: 0
    t.integer  "return_times", default: 0
    t.string   "wiki_url"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "year"
  end

  create_table "monikers", force: :cascade do |t|
    t.integer  "alias_id"
    t.integer  "avenger_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "monikers", ["alias_id"], name: "index_monikers_on_alias_id"
  add_index "monikers", ["avenger_id"], name: "index_monikers_on_avenger_id"

end
