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

ActiveRecord::Schema.define(version: 2018_12_12_001937) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string "account_name"
    t.integer "item_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "account_id_plaid"
    t.string "subtype"
    t.string "currency_type"
    t.decimal "available", precision: 8, scale: 2
    t.decimal "current", precision: 8, scale: 2
  end

  create_table "categories", force: :cascade do |t|
    t.string "category_name"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "budget_limit", precision: 11, scale: 2
  end

  create_table "category_plaid_categories", force: :cascade do |t|
    t.integer "category_id"
    t.integer "plaid_category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "items", force: :cascade do |t|
    t.string "item_name"
    t.string "item_id"
    t.string "access_token"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "institution_id"
  end

  create_table "plaid_categories", force: :cascade do |t|
    t.string "plaid_category_API_ID"
    t.string "plaid_category_name"
    t.integer "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.string "name"
    t.integer "plaid_category_API_ID"
    t.string "account_id_plaid"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "transaction_id"
    t.decimal "amount", precision: 8, scale: 2
    t.date "transaction_date"
    t.string "transaction_type"
    t.string "currency_type"
    t.boolean "pending"
    t.integer "account_id"
    t.integer "category_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
  end

  create_table "vendors", force: :cascade do |t|
    t.string "vendor_name"
    t.integer "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
