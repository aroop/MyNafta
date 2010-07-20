# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20080603024136) do

  create_table "addresses", :force => true do |t|
    t.string   "address_type"
    t.string   "name"
    t.string   "contact"
    t.string   "address_1"
    t.string   "address_2"
    t.string   "address_3"
    t.string   "address_4"
    t.string   "city"
    t.string   "county"
    t.string   "state"
    t.string   "country"
    t.string   "tax_id"
    t.string   "status"
    t.string   "dunsnumber"
    t.string   "phone_no"
    t.string   "email"
    t.string   "fax"
    t.string   "postal_code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "certified_repositories", :force => true do |t|
    t.string   "certificate_no"
    t.string   "company_name"
    t.string   "authority_name"
    t.string   "authority_signature"
    t.string   "title"
    t.string   "phone"
    t.string   "fax"
    t.binary   "attachment"
    t.string   "request_type"
    t.datetime "blanket_from_date"
    t.datetime "blanket_to_date"
    t.string   "reference_code"
    t.integer  "reference_number",    :limit => 11
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", :force => true do |t|
    t.string   "title",                          :default => ""
    t.string   "comment",                        :default => ""
    t.datetime "created_at",                                     :null => false
    t.integer  "commentable_id",   :limit => 11, :default => 0,  :null => false
    t.string   "commentable_type",               :default => "", :null => false
    t.integer  "user_id",          :limit => 11, :default => 0,  :null => false
  end

  add_index "comments", ["user_id"], :name => "fk_comments_user"

  create_table "config_values", :force => true do |t|
    t.string   "system"
    t.string   "code"
    t.string   "value"
    t.text     "description_1"
    t.text     "description_2"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "part_detail_archives", :force => true do |t|
    t.string   "status"
    t.string   "item_number"
    t.string   "supplier_item"
    t.string   "item_description"
    t.string   "hs_tariff_code"
    t.string   "pref_criteria"
    t.string   "producer"
    t.string   "net_cost"
    t.string   "nafta_coo"
    t.boolean  "item_type"
    t.integer  "plant_id",         :limit => 11
    t.text     "electronic_id"
    t.string   "product_style"
    t.boolean  "certified"
    t.string   "certificate_no"
    t.integer  "address_id",       :limit => 11
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "part_details", :force => true do |t|
    t.string   "status"
    t.string   "item_number"
    t.string   "supplier_item"
    t.string   "item_description"
    t.string   "hs_tariff_code"
    t.string   "pref_criteria"
    t.string   "producer"
    t.string   "net_cost"
    t.string   "nafta_coo"
    t.boolean  "item_type"
    t.integer  "plant_id",         :limit => 11
    t.text     "electronic_id"
    t.string   "product_style"
    t.boolean  "certified"
    t.string   "certificate_no"
    t.integer  "address_id",       :limit => 11
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_assignments", :force => true do |t|
    t.integer  "user_id",    :limit => 11
    t.integer  "address_id", :limit => 11
    t.integer  "position",   :limit => 11
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "middle_name"
    t.string   "title"
    t.string   "language"
    t.string   "email"
    t.string   "crypted_password"
    t.string   "salt"
    t.string   "company"
    t.string   "phone"
    t.string   "fax"
    t.integer  "role_id",                   :limit => 11
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "last_login"
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
    t.string   "activation_code"
    t.datetime "activated_at"
    t.string   "state",                                   :default => "passive"
    t.datetime "deleted_at"
    t.string   "password_reset_code",       :limit => 40
  end

end
