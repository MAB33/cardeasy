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

ActiveRecord::Schema.define(version: 20140817185911) do

  create_table "addresses", force: true do |t|
    t.string   "lob_id"
    t.integer  "user_id",       limit: 255
    t.string   "fname"
    t.string   "email"
    t.string   "phone"
    t.string   "address_line1"
    t.string   "address_line2"
    t.string   "city"
    t.string   "object"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "state"
    t.string   "zip"
    t.string   "country"
    t.date     "birthday"
    t.string   "lname"
  end

  create_table "addresses_cards", id: false, force: true do |t|
    t.integer "address_id", null: false
    t.integer "card_id",    null: false
  end

  create_table "card_templates", force: true do |t|
    t.string   "template_path"
    t.string   "thumb_path"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cardlings", force: true do |t|
    t.integer  "card_id"
    t.string   "file"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "order_id"
  end

  add_index "cardlings", ["card_id"], name: "index_cardlings_on_card_id"

  create_table "cards", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "file"
    t.string   "setting_id"
    t.integer  "quantity",         limit: 255
    t.string   "double_sided"
    t.string   "full_bleed"
    t.integer  "user_id",          limit: 255
    t.integer  "card_template_id"
    t.text     "message"
    t.integer  "order_id"
    t.string   "status"
    t.decimal  "price",                        precision: 8, scale: 2
  end

  create_table "orders", force: true do |t|
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "users", force: true do |t|
    t.string   "email",                              default: "", null: false
    t.string   "encrypted_password",                 default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "fname"
    t.string   "lname"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "address_id",             limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
