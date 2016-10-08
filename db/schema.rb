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

ActiveRecord::Schema.define(version: 20161006210613) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "campaigns", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "goal"
    t.datetime "end_date"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "aasm_state"
    t.string   "address"
    t.float    "longitude"
    t.float    "latitude"
    t.index ["aasm_state"], name: "index_campaigns_on_aasm_state", using: :btree
  end

  create_table "pledges", force: :cascade do |t|
    t.integer  "amount"
    t.integer  "user_id"
    t.integer  "campaign_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "stripe_txn_id"
    t.index ["campaign_id"], name: "index_pledges_on_campaign_id", using: :btree
    t.index ["user_id"], name: "index_pledges_on_user_id", using: :btree
  end

  create_table "rewards", force: :cascade do |t|
    t.string   "title"
    t.text     "body"
    t.integer  "amount"
    t.integer  "campaign_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["campaign_id"], name: "index_rewards_on_campaign_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "stripe_customer_id"
  end

  add_foreign_key "pledges", "campaigns"
  add_foreign_key "pledges", "users"
  add_foreign_key "rewards", "campaigns"
end
