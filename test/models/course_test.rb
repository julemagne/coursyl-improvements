require 'test_helper'

class CourseTest < ActiveSupport::TestCase
  test "Two primary instructors are not allowed" do
    CourseInstructor.create!(course: courses(:intro), instructor: users(:adam), primary: true)
    ci = CourseInstructor.new(course: courses(:intro), instructor: users(:bill), primary: true)
    assert !ci.save,
      "Second primary instructor was allowed to be created"
  end

  test "Two non-primary instructors are allowed" do
    ci1 = CourseInstructor.create!(course: courses(:intro), instructor: users(:adam), primary: false)
    ci2 = CourseInstructor.create!(course: courses(:intro), instructor: users(:bill), primary: false)

    assert ci2.save,
      "Two false 'primary' flags were not allowed."

    ci1.primary = nil
    ci1.save!
    ci2.primary = nil
    assert ci2.save,
      "Two nil 'primary' flags were not allowed."
  end

  test "Primary instructor name calculates correctly" do
    c = courses(:intro)
    CourseInstructor.create!(course: c, instructor: users(:adam), primary: true)
    CourseInstructor.create!(course: c, instructor: users(:bill), primary: false)
    CourseInstructor.create!(course: c, instructor: users(:carl), primary: false)
    assert c.primary_instructor_name == "Mr. Adam Adams"
  end

  test "All instructor names calculate correctly" do
    c = courses(:intro)
    CourseInstructor.create!(course: c, instructor: users(:adam), primary: true)
    CourseInstructor.create!(course: c, instructor: users(:bill), primary: false)
    CourseInstructor.create!(course: c, instructor: users(:carl), primary: false)
    all_names = c.instructor_names
    assert all_names.starts_with?("Mr. Adam Adams"),
      "Instructor_names does not start with primary instructor."
    assert all_names.include?("Dr. Carl Carlson"),
      "Non-primary instructor name missing."
    assert all_names.include?("Mrs. Barb B. Barker"),
      "Middle initial not displaying correctly."
  end
end
