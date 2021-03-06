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

ActiveRecord::Schema.define(:version => 20100913171128) do

  create_table "attachments", :force => true do |t|
    t.string   "attachment_file_name"
    t.integer  "email_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.string   "title"
    t.integer  "user_id"
  end

  create_table "email_accounts", :force => true do |t|
    t.string   "server"
    t.string   "username"
    t.string   "password"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "emails", :force => true do |t|
    t.string   "from"
    t.string   "to"
    t.string   "subject"
    t.string   "date"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.integer  "in_reply_to_id"
    t.integer  "user_id"
    t.boolean  "seen"
    t.string   "message_id"
    t.integer  "uid"
    t.integer  "email_account_id"
    t.string   "thread_id"
    t.datetime "thread_date"
    t.integer  "folder_id"
  end

  create_table "folders", :force => true do |t|
    t.integer  "parent_id"
    t.string   "title"
    t.integer  "email_account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "email_count"
    t.integer  "unseen_count"
    t.boolean  "subscribed"
    t.boolean  "synced"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                               :default => "", :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "", :null => false
    t.string   "password_salt",                       :default => "", :null => false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
