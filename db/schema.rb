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

ActiveRecord::Schema.define(:version => 20130417155231) do

  create_table "options", :force => true do |t|
    t.integer  "survey_id"
    t.string   "title"
    t.string   "locality"
    t.string   "locality_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "options", ["survey_id"], :name => "index_options_on_survey_id"

  create_table "surveys", :force => true do |t|
    t.integer  "user_id"
    t.string   "hash_url"
    t.string   "password"
    t.string   "locality"
    t.integer  "locality_id"
    t.date     "when_date"
    t.string   "when_text"
    t.date     "end_votes"
    t.string   "end_text"
    t.date     "creation"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "surveys", ["user_id"], :name => "index_surveys_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "password"
    t.string   "hash_validation"
    t.string   "email"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["hash_validation"], :name => "index_users_on_hash_validation"
  add_index "users", ["name"], :name => "index_users_on_name"

  create_table "votes", :force => true do |t|
    t.integer  "option_id"
    t.integer  "user_id"
    t.string   "username"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "votes", ["option_id"], :name => "index_votes_on_option_id"
  add_index "votes", ["user_id"], :name => "index_votes_on_user_id"
  add_index "votes", ["username"], :name => "index_votes_on_username"

end
