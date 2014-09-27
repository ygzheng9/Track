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

ActiveRecord::Schema.define(version: 20140212072035) do

  create_table "cities", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "clients", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "colleagues", force: true do |t|
    t.string   "name"
    t.text     "remark"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "dishes", force: true do |t|
    t.string   "name"
    t.text     "remark"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "drops", force: true do |t|
    t.date     "today"
    t.time     "getup_at"
    t.time     "sleep_at"
    t.integer  "step"
    t.float    "km"
    t.float    "kcal"
    t.integer  "pp"
    t.integer  "xx"
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "is_alarm"
  end

  create_table "drops_weathers", id: false, force: true do |t|
    t.integer "drop_id",    null: false
    t.integer "weather_id", null: false
  end

  create_table "expense_details", force: true do |t|
    t.date     "today"
    t.integer  "expense_type_id"
    t.integer  "payment_type_id"
    t.integer  "amount"
    t.string   "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "expense_types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hotels", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "labor_claims", force: true do |t|
    t.date     "today"
    t.integer  "project_id"
    t.integer  "hours"
    t.string   "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "meal_dishes", force: true do |t|
    t.integer  "meal_id"
    t.integer  "dish_id"
    t.float    "amount"
    t.float    "quantity"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "remark"
  end

  create_table "meals", force: true do |t|
    t.integer  "drop_id"
    t.time     "start"
    t.time     "end"
    t.text     "remark"
    t.integer  "spot_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "amount"
    t.integer  "is_paid"
    t.integer  "key_person_id"
    t.integer  "additional_person_id"
  end

  create_table "payment_types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", force: true do |t|
    t.integer  "client_id"
    t.string   "name"
    t.string   "code"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_available", default: true
  end

  create_table "segments", force: true do |t|
    t.integer  "is_valid"
    t.time     "start"
    t.time     "end"
    t.integer  "step"
    t.float    "km"
    t.float    "kcal"
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "drop_id"
  end

  create_table "sites", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "city_id"
  end

  create_table "spots", force: true do |t|
    t.string   "name"
    t.text     "remark"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stay_nights", force: true do |t|
    t.date     "today"
    t.integer  "city_id"
    t.integer  "hotel_id"
    t.float    "rate"
    t.string   "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "test", force: true do |t|
    t.text "name"
  end

  create_table "test2", force: true do |t|
    t.text "name"
  end

  create_table "weathers", force: true do |t|
    t.string   "name"
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "working_locations", force: true do |t|
    t.date     "today"
    t.integer  "site_id"
    t.float    "Taxi"
    t.string   "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
