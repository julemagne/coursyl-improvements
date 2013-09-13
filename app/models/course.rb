class Course < ActiveRecord::Base
  has_many :assignments, -> {order :due_at}
  has_many :lessons, -> {order :held_at}
  has_many :policies, -> {order :order_number}
  has_many :course_instructors, -> {order :primary}
  has_many :instructors, through: :course_instructors

  has_one :primary_course_instructor, -> {where primary: true},
    class_name: "CourseInstructor"
  has_one :primary_instructor, through: :primary_course_instructor, source: :instructor

  def instructor_names
    instructors.map{|i| i.full_name}.join(', ')
  end

  def primary_instructor_name
    primary_instructor ? primary_instructor.full_name : nil
  end
end
