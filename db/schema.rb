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

ActiveRecord::Schema.define(:version => 20140710162258) do

  create_table "agents", :force => true do |t|
    t.string   "name"
    t.boolean  "status",     :default => true, :null => false
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  create_table "channels", :force => true do |t|
    t.string   "name"
    t.decimal  "price",      :precision => 8, :scale => 2
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
  end

  create_table "packages", :force => true do |t|
    t.string   "name"
    t.text     "channels"
    t.decimal  "price",      :precision => 8, :scale => 2
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
  end

  create_table "payments", :force => true do |t|
    t.string   "payment_ref"
    t.integer  "subscriber_id"
    t.decimal  "amount",        :precision => 10, :scale => 0
    t.date     "for_cycle"
    t.integer  "agent_id"
    t.date     "collected_on"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at",                                   :null => false
    t.datetime "updated_at",                                   :null => false
  end

  create_table "subscribers", :force => true do |t|
    t.string   "smartcard_number"
    t.string   "name"
    t.string   "address"
    t.integer  "cycle_starts_on"
    t.text     "packages"
    t.text     "channels"
    t.decimal  "subscription_amount", :precision => 8, :scale => 2, :default => 0.0
    t.boolean  "status",                                            :default => true, :null => false
    t.datetime "created_at",                                                          :null => false
    t.datetime "updated_at",                                                          :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "password_digest"
    t.boolean  "status",          :default => true, :null => false
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.text     "roles"
  end

end
