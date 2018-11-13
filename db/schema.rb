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

ActiveRecord::Schema.define(version: 20171108175611) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "audits", force: :cascade do |t|
    t.integer  "auditable_id"
    t.string   "auditable_type"
    t.integer  "associated_id"
    t.string   "associated_type"
    t.integer  "user_id"
    t.string   "user_type"
    t.string   "username"
    t.string   "action"
    t.text     "audited_changes"
    t.integer  "version",         default: 0
    t.string   "comment"
    t.string   "remote_address"
    t.string   "request_uuid"
    t.datetime "created_at"
    t.index ["associated_id", "associated_type"], name: "associated_index", using: :btree
    t.index ["auditable_id", "auditable_type"], name: "auditable_index", using: :btree
    t.index ["created_at"], name: "index_audits_on_created_at", using: :btree
    t.index ["request_uuid"], name: "index_audits_on_request_uuid", using: :btree
    t.index ["user_id", "user_type"], name: "user_index", using: :btree
  end

  create_table "players", force: :cascade do |t|
    t.string   "name"
    t.integer  "division"
    t.integer  "position"
    t.decimal  "points",         precision: 20, scale: 6
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.integer  "season_id"
    t.string   "division_title"
    t.index ["season_id"], name: "index_players_on_season_id", using: :btree
  end

  create_table "seasons", force: :cascade do |t|
    t.string   "name"
    t.string   "foos_id"
    t.boolean  "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shares", force: :cascade do |t|
    t.integer  "amount"
    t.decimal  "buy_price",      precision: 20, scale: 6
    t.integer  "player_id"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.integer  "user_season_id"
    t.index ["player_id"], name: "index_shares_on_player_id", using: :btree
    t.index ["user_season_id"], name: "index_shares_on_user_season_id", using: :btree
  end

  create_table "user_seasons", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "season_id"
    t.decimal  "credit",       precision: 20, scale: 6, default: "0.0"
    t.decimal  "shares_value", precision: 20, scale: 6, default: "0.0"
    t.datetime "created_at",                                            null: false
    t.datetime "updated_at",                                            null: false
    t.index ["season_id"], name: "index_user_seasons_on_season_id", using: :btree
    t.index ["user_id"], name: "index_user_seasons_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "social_id"
    t.string   "name"
    t.string   "email"
    t.string   "image"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.boolean  "receives_mail"
    t.index ["social_id"], name: "index_users_on_social_id", unique: true, using: :btree
  end

  add_foreign_key "user_seasons", "seasons"
  add_foreign_key "user_seasons", "users"
end
