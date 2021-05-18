# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_03_05_123656) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "role", default: 0, null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "catalogues", force: :cascade do |t|
    t.string "name", null: false
    t.text "description", null: false
    t.decimal "price", null: false
    t.bigint "category_id", null: false
    t.string "image", null: false, array: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category_id"], name: "index_catalogues_on_category_id"
  end

  create_table "categories", force: :cascade do |t|
    t.integer "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "favorite_tailors", force: :cascade do |t|
    t.bigint "tailor_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["tailor_id"], name: "index_favorite_tailors_on_tailor_id"
    t.index ["user_id", "tailor_id"], name: "index_favorite_tailors_on_user_id_and_tailor_id", unique: true
    t.index ["user_id"], name: "index_favorite_tailors_on_user_id"
  end

  create_table "order_images", force: :cascade do |t|
    t.bigint "order_id", null: false
    t.string "image"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["order_id"], name: "index_order_images_on_order_id"
  end

  create_table "order_item_size_profile_fields", force: :cascade do |t|
    t.integer "value", default: 0, null: false
    t.bigint "order_item_size_profile_id", null: false
    t.bigint "standard_field_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["order_item_size_profile_id"], name: "order_iteem_prof_index"
    t.index ["standard_field_id"], name: "index_order_item_size_profile_fields_on_standard_field_id"
    t.index ["user_id", "standard_field_id", "order_item_size_profile_id"], name: "standard_orde_items_filed_unique", unique: true
    t.index ["user_id"], name: "index_order_item_size_profile_fields_on_user_id"
  end

  create_table "order_item_size_profiles", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "user_id", null: false
    t.bigint "order_item_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "gender", default: 0, null: false
    t.index ["order_item_id"], name: "index_order_item_size_profiles_on_order_item_id"
    t.index ["user_id"], name: "index_order_item_size_profiles_on_user_id"
  end

  create_table "order_items", force: :cascade do |t|
    t.bigint "order_id", null: false
    t.bigint "category_id", null: false
    t.bigint "skill_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "size_profile_id"
    t.bigint "tailor_id", null: false
    t.index ["category_id"], name: "index_order_items_on_category_id"
    t.index ["order_id"], name: "index_order_items_on_order_id"
    t.index ["size_profile_id"], name: "index_order_items_on_size_profile_id"
    t.index ["skill_id"], name: "index_order_items_on_skill_id"
    t.index ["tailor_id"], name: "index_order_items_on_tailor_id"
    t.index ["user_id"], name: "index_order_items_on_user_id"
  end

  create_table "orders", force: :cascade do |t|
    t.string "urgency_type"
    t.text "comment"
    t.integer "status"
    t.bigint "user_id", null: false
    t.bigint "proposal_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "number", default: 0, null: false
    t.integer "year", default: 0, null: false
    t.bigint "tailor_id"
    t.string "name", null: false
    t.integer "fabric_type", default: 0, null: false
    t.datetime "due_date", null: false
    t.decimal "bidding_price", null: false
    t.index ["proposal_id"], name: "index_orders_on_proposal_id"
    t.index ["tailor_id"], name: "index_orders_on_tailor_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
    t.index ["year", "number", "user_id"], name: "order_year_number_uniqueness", unique: true
  end

  create_table "portfolio_images", force: :cascade do |t|
    t.string "image"
    t.bigint "portfolio_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["portfolio_id"], name: "index_portfolio_images_on_portfolio_id"
  end

  create_table "portfolios", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.bigint "user_id"
    t.bigint "category_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category_id"], name: "index_portfolios_on_category_id"
    t.index ["user_id"], name: "index_portfolios_on_user_id"
  end

  create_table "proposal_biddings", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "proposal_id", null: false
    t.integer "status", default: 0, null: false
    t.decimal "bidding_price"
    t.datetime "due_date"
    t.boolean "invite_only", default: true, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["proposal_id"], name: "index_proposal_biddings_on_proposal_id"
    t.index ["user_id"], name: "index_proposal_biddings_on_user_id"
  end

  create_table "proposal_images", force: :cascade do |t|
    t.bigint "proposal_id", null: false
    t.string "image"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["proposal_id"], name: "index_proposal_images_on_proposal_id"
  end

  create_table "proposal_items", force: :cascade do |t|
    t.bigint "proposal_id", null: false
    t.bigint "category_id", null: false
    t.bigint "skill_id", null: false
    t.bigint "size_profile_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category_id"], name: "index_proposal_items_on_category_id"
    t.index ["proposal_id"], name: "index_proposal_items_on_proposal_id"
    t.index ["size_profile_id"], name: "index_proposal_items_on_size_profile_id"
    t.index ["skill_id"], name: "index_proposal_items_on_skill_id"
  end

  create_table "proposals", force: :cascade do |t|
    t.string "urgency_type"
    t.text "comment"
    t.integer "status"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "number", default: 0, null: false
    t.integer "year", default: 0, null: false
    t.string "name", null: false
    t.integer "fabric_type", default: 0, null: false
    t.index ["number", "year", "user_id"], name: "proposal_year_number_uniqueness", unique: true
    t.index ["user_id"], name: "index_proposals_on_user_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.text "review"
    t.integer "user_id"
    t.decimal "rating"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "comment"
    t.bigint "tailor_id"
    t.bigint "order_id", null: false
    t.index ["order_id"], name: "index_reviews_on_order_id"
    t.index ["tailor_id"], name: "index_reviews_on_tailor_id"
  end

  create_table "size_profile_fields", force: :cascade do |t|
    t.integer "value", default: 0, null: false
    t.bigint "size_profile_id", null: false
    t.bigint "standard_field_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["size_profile_id"], name: "index_size_profile_fields_on_size_profile_id"
    t.index ["standard_field_id"], name: "index_size_profile_fields_on_standard_field_id"
    t.index ["user_id", "standard_field_id", "size_profile_id"], name: "standard_user_profile_fileds_uniqueness", unique: true
    t.index ["user_id"], name: "index_size_profile_fields_on_user_id"
  end

  create_table "size_profiles", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "gender", default: 0, null: false
    t.index ["user_id"], name: "index_size_profiles_on_user_id"
  end

  create_table "skills", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "category_id"
  end

  create_table "standard_fields", force: :cascade do |t|
    t.integer "name", null: false
    t.integer "gender", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "unit", default: 0, null: false
  end

  create_table "tailor_skills", force: :cascade do |t|
    t.decimal "experience"
    t.string "description"
    t.bigint "user_id"
    t.bigint "skill_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.decimal "cost", default: "0.0", null: false
    t.index ["skill_id"], name: "index_tailor_skills_on_skill_id"
    t.index ["user_id"], name: "index_tailor_skills_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean "allow_password_change", default: false
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.string "name"
    t.string "nickname"
    t.string "image"
    t.string "email"
    t.json "tokens"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "role"
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "cnic"
    t.datetime "dob"
    t.string "phone_number"
    t.string "whatsapp_number"
    t.string "about_me"
    t.integer "gender"
    t.string "profile_photo"
    t.string "cover_photo"
    t.string "street"
    t.string "city"
    t.string "state"
    t.string "zip"
    t.string "country"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

  add_foreign_key "catalogues", "categories"
  add_foreign_key "favorite_tailors", "users", column: "tailor_id"
  add_foreign_key "order_images", "orders"
  add_foreign_key "order_items", "categories"
  add_foreign_key "order_items", "orders"
  add_foreign_key "order_items", "size_profiles"
  add_foreign_key "order_items", "skills"
  add_foreign_key "order_items", "users"
  add_foreign_key "order_items", "users", column: "tailor_id"
  add_foreign_key "orders", "proposals"
  add_foreign_key "orders", "users"
  add_foreign_key "orders", "users", column: "tailor_id"
  add_foreign_key "portfolio_images", "portfolios"
  add_foreign_key "portfolios", "categories"
  add_foreign_key "portfolios", "users"
  add_foreign_key "proposal_biddings", "proposals"
  add_foreign_key "proposal_biddings", "users"
  add_foreign_key "proposal_images", "proposals"
  add_foreign_key "proposal_items", "categories"
  add_foreign_key "proposal_items", "proposals"
  add_foreign_key "proposal_items", "size_profiles"
  add_foreign_key "proposal_items", "skills"
  add_foreign_key "proposals", "users"
  add_foreign_key "reviews", "orders"
  add_foreign_key "reviews", "users", column: "tailor_id"
  add_foreign_key "tailor_skills", "skills"
  add_foreign_key "tailor_skills", "users"
end
