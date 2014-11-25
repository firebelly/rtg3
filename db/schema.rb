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

ActiveRecord::Schema.define(version: 20141125230603) do

  create_table "carts", force: true do |t|
    t.integer  "session_id"
    t.integer  "order_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "donations", force: true do |t|
    t.integer  "cart_id"
    t.integer  "reason_id"
    t.decimal  "amount",     precision: 10, scale: 2, default: 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "friendly_id_slugs", force: true do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "orders", force: true do |t|
    t.string   "payment_type"
    t.string   "payment_status"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "zip"
    t.boolean  "newsletter",                              default: false
    t.decimal  "total",          precision: 10, scale: 2, default: 0.0
    t.string   "found"
    t.string   "found_other"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pages", force: true do |t|
    t.string   "title"
    t.string   "slug"
    t.text     "content"
    t.boolean  "published"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "title_override"
    t.string   "banner_title"
  end

  create_table "payment_records", force: true do |t|
    t.integer  "order_id"
    t.text     "params"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "post_types", force: true do |t|
    t.string   "name"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "post_types", ["slug"], name: "index_post_types_on_slug", unique: true, using: :btree

  create_table "posts", force: true do |t|
    t.string   "title"
    t.string   "slug"
    t.text     "content"
    t.date     "post_date"
    t.boolean  "published"
    t.integer  "post_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "icon"
  end

  add_index "posts", ["slug"], name: "index_posts_on_slug", unique: true, using: :btree

  create_table "reason_images", force: true do |t|
    t.integer  "reason_id"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reasons", force: true do |t|
    t.string   "title"
    t.string   "slug"
    t.date     "post_date"
    t.text     "excerpt"
    t.text     "content"
    t.decimal  "total_needed",                 precision: 10, scale: 2, default: 0.0
    t.decimal  "total_donated",                precision: 10, scale: 2, default: 0.0
    t.boolean  "published"
    t.boolean  "promoted"
    t.boolean  "is_success"
    t.text     "success_excerpt"
    t.text     "success_content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "secondary_image_file_name"
    t.string   "secondary_image_content_type"
    t.integer  "secondary_image_file_size"
    t.datetime "secondary_image_updated_at"
  end

  add_index "reasons", ["slug"], name: "index_reasons_on_slug", unique: true, using: :btree

  create_table "supporter_types", force: true do |t|
    t.string   "title"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "supporter_types", ["slug"], name: "index_supporter_types_on_slug", unique: true, using: :btree

  create_table "supporters", force: true do |t|
    t.string   "title"
    t.string   "url"
    t.integer  "supporter_type_id"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
