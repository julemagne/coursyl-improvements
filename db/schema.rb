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

ActiveRecord::Schema.define(version: 20131205015713) do

  create_table "assignment_grades", force: true do |t|
    t.integer  "assignment_id"
    t.integer  "course_student_id"
    t.float    "final_grade"
    t.datetime "submitted_at"
    t.datetime "graded_at"
    t.text     "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "assignment_question_grades", force: true do |t|
    t.integer  "assignment_question_id"
    t.integer  "assignment_grade_id"
    t.float    "grade"
    t.text     "answer"
    t.text     "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "assignment_questions", force: true do |t|
    t.integer  "assignment_id"
    t.text     "question"
    t.integer  "points"
    t.integer  "order_number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "assignments", force: true do |t|
    t.string   "name"
    t.integer  "course_id"
    t.datetime "active_at"
    t.datetime "due_at"
    t.boolean  "grades_released"
    t.boolean  "students_can_submit"
    t.float    "fraction_of_grade"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "maximum_grade"
  end

  create_table "course_instructors", force: true do |t|
    t.integer  "course_id"
    t.integer  "instructor_id"
    t.boolean  "primary"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "course_students", force: true do |t|
    t.integer  "student_id"
    t.integer  "course_id"
    t.float    "final_grade"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "courses", force: true do |t|
    t.string   "name"
    t.string   "course_code"
    t.string   "color"
    t.string   "period"
    t.text     "description"
    t.date     "started_on"
    t.date     "ended_on"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "grade_thresholds", force: true do |t|
    t.integer  "course_id"
    t.float    "grade"
    t.string   "letter"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lessons", force: true do |t|
    t.integer  "course_id"
    t.integer  "parent_lesson_id"
    t.string   "name"
    t.datetime "held_at"
    t.text     "description"
    t.text     "outline"
    t.text     "lead_in_question"
    t.text     "video_url"
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

  create_table "readings", force: true do |t|
    t.integer  "lesson_id"
    t.string   "caption"
    t.string   "url"
    t.integer  "order_number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "title"
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "last_name"
    t.string   "phone"
    t.string   "office"
    t.string   "office_hours"
    t.string   "photo_url"
    t.text     "description"
    t.boolean  "admin"
    t.datetime "created_at"
    t.datetime "updated_at"
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
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
