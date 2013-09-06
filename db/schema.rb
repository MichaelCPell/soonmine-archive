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

ActiveRecord::Schema.define(version: 20130901190518) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authentications", force: true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "access_token"
    t.string   "token_expiration"
    t.integer  "user_id"
    t.string   "refresh_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contacts", force: true do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.string   "relationship"
    t.integer  "user_id"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lists", force: true do |t|
    t.string   "title",       default: "Primary"
    t.string   "description"
    t.integer  "user_id"
    t.string   "privacy"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", force: true do |t|
    t.string   "name",        default: "No Product Name"
    t.integer  "price",       default: 0
    t.string   "image_url",   default: "/assets/no_product_image.jpg"
    t.string   "state"
    t.integer  "quantity"
    t.string   "offsite_url"
    t.integer  "intensity"
    t.integer  "list_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reminders", force: true do |t|
    t.string   "name"
    t.date     "date"
    t.integer  "user_id"
    t.string   "recipient_email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.string   "image_url",              default: "/assets/missing_profile_image.png"
    t.string   "country"
    t.string   "state"
    t.string   "town"
    t.string   "zipcode"
    t.string   "street_address"
    t.date     "birthday"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email"
    t.string   "encrypted_password",     default: "",                                  null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "filepicker_url"
  end

end
