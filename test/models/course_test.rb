require 'test_helper'

class CourseTest < ActiveSupport::TestCase
  c = Course.create!(name: "Intro")
  i1 = Instructor.create!(first_name: "Adam", last_name: "Adams")
  i2 = Instructor.create!(first_name: "Bill", middle_name: "Bob", last_name: "Barker")
  i3 = Instructor.create!(title: "Dr.", first_name: "Carl", last_name: "Carlson")

  s1 = CourseInstructor.create!(course: c, instructor: i1, primary: true)
  s2 = CourseInstructor.new(course: c, instructor: i2)
  s3 = CourseInstructor.new(course: c, instructor: i3)

  test "Two primary instructors are not allowed" do
    s2.primary = true
    assert !s2.save,
      "Second primary instructor was allowed to be created"
  end

  test "Two non-primary instructors are allowed" do
    s2.primary = false
    s2.save!

    s3.primary = false
    assert s3.save,
      "Two false 'primary' flags were not allowed."

    s2.primary = nil
    s2.save!
    s3.primary = nil
    assert s3.save,
      "Two nil 'primary' flags were not allowed."
  end

  test "Primary instructor name calculates correctly" do
    assert c.primary_instructor_name == "Adam Adams"
  end

  test "All instructor names calculate correctly" do
    all_names = c.instructor_names
    assert all_names.starts_with?("Adam Adams"),
      "instructor_names does not start with primary instructor."
    assert all_names.includes?("Bill B. Barker"),
      "Middle initial not displaying correctly."
    assert all_names.includes?("Dr. Carl Carlson"),
      "Title not displaying correctly."
  end
end
