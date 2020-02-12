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

ActiveRecord::Schema.define(version: 2020_02_12_165626) do

  create_table "alerts", force: :cascade do |t|
    t.integer "campground_id"
    t.integer "user_id"
    t.date "start_date"
    t.date "end_date"
    t.boolean "has_triggered?", default: false
  end

  create_table "availabilities", force: :cascade do |t|
    t.integer "campground_id"
    t.date "date"
    t.boolean "open?"
    t.integer "sites_available"
  end

  create_table "campgrounds", force: :cascade do |t|
    t.string "name"
    t.integer "official_facility_id"
    t.string "description"
    t.integer "rec_area_id"
  end

  create_table "rec_areas", force: :cascade do |t|
    t.string "name"
    t.integer "official_rec_area_id"
    t.string "state_code"
    t.string "description"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
  end

end
