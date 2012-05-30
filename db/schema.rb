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

ActiveRecord::Schema.define(:version => 20120530021417) do

  create_table "companies", :force => true do |t|
    t.string   "name",        :null => false
    t.text     "description"
    t.string   "website"
    t.string   "linkedin"
    t.string   "status"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

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

  create_table "deals", :force => true do |t|
    t.date     "deal_date"
    t.string   "category"
    t.string   "round"
    t.integer  "amount"
    t.integer  "pre_valuation"
    t.string   "source_url"
    t.integer  "company_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "deals", ["company_id"], :name => "index_deals_on_company_id"

  create_table "deals_investors", :id => false, :force => true do |t|
    t.integer "deal_id"
    t.integer "investor_id"
  end

  add_index "deals_investors", ["deal_id", "investor_id"], :name => "index_deals_investors_on_deal_id_and_investor_id"
  add_index "deals_investors", ["investor_id", "deal_id"], :name => "index_deals_investors_on_investor_id_and_deal_id"

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
  end

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
    t.string   "region"
    t.string   "city",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "markets", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  add_index "roles_users", ["role_id", "user_id"], :name => "index_roles_users_on_role_id_and_user_id"
  add_index "roles_users", ["user_id", "role_id"], :name => "index_roles_users_on_user_id_and_role_id"

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "full_name"
    t.datetime "created_at",                                            :null => false
    t.datetime "updated_at",                                            :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
