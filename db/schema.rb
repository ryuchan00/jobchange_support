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

ActiveRecord::Schema.define(version: 20170405125601) do

  create_table "items", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "code"
    t.string   "name"
    t.string   "url"
    t.string   "image_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "links", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "provider"
    t.string   "link"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_links_on_user_id", using: :btree
  end

  create_table "ownerships", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "type"
    t.integer  "user_id"
    t.integer  "item_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_ownerships_on_item_id", using: :btree
    t.index ["user_id", "item_id", "type"], name: "index_ownerships_on_user_id_and_item_id_and_type", unique: true, using: :btree
    t.index ["user_id"], name: "index_ownerships_on_user_id", using: :btree
  end

  create_table "social_profiles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "nickname"
    t.string   "email"
    t.string   "url"
    t.string   "image_url"
    t.string   "description"
    t.text     "other",       limit: 65535
    t.text     "credentials", limit: 65535
    t.text     "raw_info",    limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.index ["provider", "uid"], name: "index_social_profiles_on_provider_and_uid", unique: true, using: :btree
    t.index ["user_id"], name: "index_social_profiles_on_user_id", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "provider"
    t.string   "uid"
    t.string   "image_url"
  end

  add_foreign_key "links", "users"
  add_foreign_key "ownerships", "items"
  add_foreign_key "ownerships", "users"
  add_foreign_key "social_profiles", "users"
end
