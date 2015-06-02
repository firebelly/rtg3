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

ActiveRecord::Schema.define(version: 20150223175628) do

  create_table "applicants", force: :cascade do |t|
    t.string   "first_name",         limit: 255
    t.string   "last_name",          limit: 255
    t.string   "phone",              limit: 255
    t.string   "email",              limit: 255
    t.string   "form",               limit: 255
    t.text     "params",             limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "subject",            limit: 255
    t.text     "message",            limit: 65535
    t.string   "address",            limit: 255
    t.string   "city",               limit: 255
    t.string   "state",              limit: 255
    t.string   "zip_code",           limit: 255
    t.string   "contact_preference", limit: 255
  end

  create_table "carts", force: :cascade do |t|
    t.string   "session_id", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "carts", ["session_id"], name: "index_carts_on_session_id", using: :btree

  create_table "donation_items", force: :cascade do |t|
    t.integer  "cart_id",     limit: 4
    t.integer  "reason_id",   limit: 4
    t.decimal  "amount",                precision: 10, scale: 2, default: 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "donation_id", limit: 4
  end

  add_index "donation_items", ["cart_id", "reason_id"], name: "index_donation_items_on_cart_id_and_reason_id", using: :btree
  add_index "donation_items", ["cart_id"], name: "index_donation_items_on_cart_id", using: :btree
  add_index "donation_items", ["donation_id"], name: "index_donation_items_on_donation_id", using: :btree
  add_index "donation_items", ["reason_id"], name: "index_donation_items_on_reason_id", using: :btree

  create_table "donations", force: :cascade do |t|
    t.string   "payment_id",     limit: 255
    t.string   "payment_type",   limit: 255
    t.string   "payment_status", limit: 255
    t.string   "first_name",     limit: 255
    t.string   "last_name",      limit: 255
    t.string   "address",        limit: 255
    t.string   "city",           limit: 255
    t.string   "state",          limit: 255
    t.string   "email",          limit: 255
    t.string   "zip",            limit: 255
    t.boolean  "newsletter",     limit: 1,                              default: false
    t.decimal  "total",                        precision: 10, scale: 2, default: 0.0
    t.string   "found",          limit: 255
    t.string   "found_other",    limit: 255
    t.text     "notes",          limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",           limit: 255, null: false
    t.integer  "sluggable_id",   limit: 4,   null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope",          limit: 255
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "page_images", force: :cascade do |t|
    t.integer  "page_id",            limit: 4
    t.string   "image_file_name",    limit: 255
    t.string   "image_content_type", limit: 255
    t.integer  "image_file_size",    limit: 4
    t.datetime "image_updated_at"
    t.string   "caption",            limit: 255
    t.integer  "position",           limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pages", force: :cascade do |t|
    t.string   "title",              limit: 255
    t.string   "slug",               limit: 255
    t.text     "content",            limit: 65535
    t.boolean  "published",          limit: 1
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name",    limit: 255
    t.string   "image_content_type", limit: 255
    t.integer  "image_file_size",    limit: 4
    t.datetime "image_updated_at"
    t.string   "title_override",     limit: 255
    t.string   "banner_title",       limit: 255
    t.text     "description",        limit: 65535
  end

  add_index "pages", ["slug"], name: "index_pages_on_slug", unique: true, using: :btree

  create_table "payment_records", force: :cascade do |t|
    t.integer  "donation_id", limit: 4
    t.text     "params",      limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "post_types", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "slug",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "post_types", ["slug"], name: "index_post_types_on_slug", unique: true, using: :btree

  create_table "posts", force: :cascade do |t|
    t.string   "title",        limit: 255
    t.string   "slug",         limit: 255
    t.text     "content",      limit: 65535
    t.date     "post_date"
    t.boolean  "published",    limit: 1
    t.integer  "post_type_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "icon",         limit: 255
    t.string   "url",          limit: 255
  end

  add_index "posts", ["post_type_id", "published"], name: "index_posts_on_post_type_id_and_published", using: :btree
  add_index "posts", ["slug"], name: "index_posts_on_slug", unique: true, using: :btree

  create_table "quotes", force: :cascade do |t|
    t.integer  "page_id",    limit: 4
    t.text     "quote",      limit: 65535
    t.string   "quotee",     limit: 255
    t.string   "title",      limit: 255
    t.string   "location",   limit: 255
    t.integer  "position",   limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "quotes", ["page_id"], name: "index_quotes_on_page_id", using: :btree

  create_table "reason_images", force: :cascade do |t|
    t.integer  "reason_id",          limit: 4
    t.string   "image_file_name",    limit: 255
    t.string   "image_content_type", limit: 255
    t.integer  "image_file_size",    limit: 4
    t.datetime "image_updated_at"
    t.integer  "position",           limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "caption",            limit: 255
  end

  create_table "reasons", force: :cascade do |t|
    t.string   "title",                        limit: 255
    t.string   "slug",                         limit: 255
    t.date     "post_date"
    t.text     "excerpt",                      limit: 65535
    t.text     "content",                      limit: 65535
    t.decimal  "total_needed",                               precision: 8, scale: 2, default: 0.0
    t.decimal  "total_donated",                              precision: 8, scale: 2, default: 0.0
    t.boolean  "published",                    limit: 1
    t.boolean  "promoted",                     limit: 1
    t.boolean  "is_success",                   limit: 1
    t.boolean  "fulfilled",                    limit: 1,                             default: false
    t.text     "success_excerpt",              limit: 65535
    t.text     "success_content",              limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name",              limit: 255
    t.string   "image_content_type",           limit: 255
    t.integer  "image_file_size",              limit: 4
    t.datetime "image_updated_at"
    t.string   "secondary_image_file_name",    limit: 255
    t.string   "secondary_image_content_type", limit: 255
    t.integer  "secondary_image_file_size",    limit: 4
    t.datetime "secondary_image_updated_at"
    t.string   "donation_prompt",              limit: 255
    t.string   "featured_video",               limit: 255
    t.string   "success_donation_prompt",      limit: 255
    t.string   "success_title",                limit: 255
  end

  add_index "reasons", ["published", "is_success", "promoted"], name: "index_reasons_on_published_and_is_success_and_promoted", using: :btree
  add_index "reasons", ["published", "promoted"], name: "index_reasons_on_published_and_promoted", using: :btree
  add_index "reasons", ["slug"], name: "index_reasons_on_slug", unique: true, using: :btree

  create_table "supporter_types", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.string   "slug",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "supporter_types", ["slug"], name: "index_supporter_types_on_slug", unique: true, using: :btree

  create_table "supporters", force: :cascade do |t|
    t.string   "title",             limit: 255
    t.string   "url",               limit: 255
    t.integer  "supporter_type_id", limit: 4
    t.string   "logo_file_name",    limit: 255
    t.string   "logo_content_type", limit: 255
    t.integer  "logo_file_size",    limit: 4
    t.datetime "logo_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "supporters", ["supporter_type_id"], name: "index_supporters_on_supporter_type_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
