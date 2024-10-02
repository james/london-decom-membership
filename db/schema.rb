# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2024_09_15_235553) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "direct_sale_codes", force: :cascade do |t|
    t.string "code"
    t.bigint "user_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["user_id"], name: "index_direct_sale_codes_on_user_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "eventbrite_token"
    t.string "eventbrite_id"
    t.string "name"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.boolean "active", default: false, null: false
    t.datetime "ticket_sale_start_date", precision: nil
    t.text "theme"
    t.text "theme_details"
    t.text "theme_image_url"
    t.text "location"
    t.text "maps_location_url"
    t.text "event_timings"
    t.text "further_information"
    t.datetime "event_date", precision: nil
    t.integer "event_mode"
    t.text "ticket_price_info"
    t.text "ticket_information"
    t.datetime "low_income_requests_start", precision: nil
    t.datetime "low_income_requests_end", precision: nil
  end

  create_table "low_income_codes", force: :cascade do |t|
    t.string "code"
    t.bigint "low_income_request_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["low_income_request_id"], name: "index_low_income_codes_on_low_income_request_id"
  end

  create_table "low_income_requests", force: :cascade do |t|
    t.bigint "user_id"
    t.text "request_reason"
    t.string "status"
    t.text "status_reason"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["user_id"], name: "index_low_income_requests_on_user_id"
  end

  create_table "membership_codes", force: :cascade do |t|
    t.string "code"
    t.bigint "user_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["user_id"], name: "index_membership_codes_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "name"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at", precision: nil
    t.datetime "remember_created_at", precision: nil
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at", precision: nil
    t.datetime "last_sign_in_at", precision: nil
    t.string "confirmation_token"
    t.datetime "confirmed_at", precision: nil
    t.datetime "confirmation_sent_at", precision: nil
    t.string "unconfirmed_email"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.boolean "admin"
    t.boolean "marketing_opt_in", default: false, null: false
    t.boolean "early_access"
    t.boolean "ticket_bought"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "volunteer_roles", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.bigint "event_id"
    t.boolean "hidden"
    t.text "brief_description"
    t.integer "priority"
    t.index ["event_id"], name: "index_volunteer_roles_on_event_id"
  end

  create_table "volunteers", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "volunteer_role_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.boolean "lead", default: false, null: false
    t.string "state", default: "new"
    t.string "phone"
    t.text "additional_comments"
    t.index ["user_id"], name: "index_volunteers_on_user_id"
    t.index ["volunteer_role_id"], name: "index_volunteers_on_volunteer_role_id"
  end

  add_foreign_key "direct_sale_codes", "users"
  add_foreign_key "low_income_codes", "low_income_requests"
  add_foreign_key "low_income_requests", "users"
  add_foreign_key "membership_codes", "users"
  add_foreign_key "volunteer_roles", "events"
  add_foreign_key "volunteers", "users"
  add_foreign_key "volunteers", "volunteer_roles"
end
