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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120915201401) do

  create_table "companies", :force => true do |t|
    t.string   "name",        :null => false
    t.text     "description"
    t.string   "website"
    t.string   "linkedin"
    t.string   "status"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "slug"
  end

  add_index "companies", ["slug"], :name => "index_companies_on_slug", :unique => true

  create_table "companies_locations", :id => false, :force => true do |t|
    t.integer "company_id"
    t.integer "location_id"
  end

  add_index "companies_locations", ["company_id", "location_id"], :name => "index_companies_locations_on_company_id_and_location_id"
  add_index "companies_locations", ["location_id", "company_id"], :name => "index_companies_locations_on_location_id_and_company_id"

  create_table "companies_markets", :id => false, :force => true do |t|
    t.integer "company_id"
    t.integer "market_id"
  end

  add_index "companies_markets", ["company_id", "market_id"], :name => "index_companies_markets_on_company_id_and_market_id"
  add_index "companies_markets", ["market_id", "company_id"], :name => "index_companies_markets_on_market_id_and_company_id"

  create_table "dealings", :force => true do |t|
    t.integer  "deal_id"
    t.integer  "buyer_id"
    t.string   "buyer_type"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "dealings", ["buyer_id", "buyer_type"], :name => "index_dealings_on_buyer_id_and_buyer_type"
  add_index "dealings", ["deal_id", "buyer_id", "buyer_type"], :name => "index_dealings_on_deal_id_and_buyer_id_and_buyer_type", :unique => true
  add_index "dealings", ["deal_id"], :name => "index_dealings_on_deal_id"

  create_table "deals", :force => true do |t|
    t.date     "close_date",    :null => false
    t.string   "category"
    t.string   "round"
    t.string   "currency"
    t.integer  "amount"
    t.integer  "pre_valuation"
    t.text     "source_url"
    t.integer  "company_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.boolean  "verified"
  end

  add_index "deals", ["company_id"], :name => "index_deals_on_company_id"

  create_table "investors", :force => true do |t|
    t.string   "name",        :null => false
    t.text     "description"
    t.string   "website"
    t.string   "linkedin"
    t.string   "status"
    t.string   "category"
    t.string   "stage"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "slug"
  end

  add_index "investors", ["slug"], :name => "index_investors_on_slug", :unique => true

  create_table "investors_locations", :id => false, :force => true do |t|
    t.integer "investor_id"
    t.integer "location_id"
  end

  add_index "investors_locations", ["investor_id", "location_id"], :name => "index_investors_locations_on_investor_id_and_location_id"
  add_index "investors_locations", ["location_id", "investor_id"], :name => "index_investors_locations_on_location_id_and_investor_id"

  create_table "investors_markets", :id => false, :force => true do |t|
    t.integer "investor_id"
    t.integer "market_id"
  end

  add_index "investors_markets", ["investor_id", "market_id"], :name => "index_investors_markets_on_investor_id_and_market_id"
  add_index "investors_markets", ["market_id", "investor_id"], :name => "index_investors_markets_on_market_id_and_investor_id"

  create_table "locations", :force => true do |t|
    t.string   "country",    :null => false
    t.string   "region",     :null => false
    t.string   "city",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "markets", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "searches", :force => true do |t|
    t.string   "keywords"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "slug"
  end

  add_index "searches", ["slug"], :name => "index_searches_on_slug", :unique => true

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "full_name",                              :null => false
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "role"
    t.string   "provider"
    t.string   "uid"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "versions", :force => true do |t|
    t.string   "item_type",  :null => false
    t.integer  "item_id",    :null => false
    t.string   "event",      :null => false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], :name => "index_versions_on_item_type_and_item_id"

end
