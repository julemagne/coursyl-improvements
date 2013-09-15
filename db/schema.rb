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

ActiveRecord::Schema.define(version: 20130831022017) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "assignments", force: true do |t|
    t.string   "name"
    t.integer  "course_id"
    t.datetime "active_at"
    t.datetime "due_at"
    t.boolean  "students_can_submit"
    t.float    "fraction_of_grade"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "course_instructors", force: true do |t|
    t.integer  "course_id"
    t.integer  "instructor_id"
    t.boolean  "primary"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "courses", force: true do |t|
    t.integer  "term_id"
    t.string   "name"
    t.string   "course_code"
    t.string   "period"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "instructors", force: true do |t|
    t.string   "title"
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "phone"
    t.string   "office"
    t.string   "office_hours"
    t.string   "photo_url"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lessons", force: true do |t|
    t.integer  "course_id"
    t.integer  "parent_lesson_id"
    t.string   "name"
    t.datetime "held_at"
    t.text     "lead_in_reading"
    t.text     "lead_in_question"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "policies", force: true do |t|
    t.integer  "course_id"
    t.string   "name"
    t.integer  "order_number"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
