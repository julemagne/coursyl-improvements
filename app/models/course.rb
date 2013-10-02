class Course < ActiveRecord::Base
  has_many :assignments, -> {order :due_at}
  has_many :lessons, -> {order :held_at}
  has_many :policies, -> {order :order_number}
  has_many :course_instructors
  has_many :instructors, through: :course_instructors

  has_one :primary_course_instructor, -> {where primary: true},
    class_name: "CourseInstructor"
  has_one :primary_instructor, through: :primary_course_instructor, source: :instructor

  def self.example_courses
    self.order("id DESC").last(5)
  end

  def code_and_name
    "#{course_code}: #{name}"
  end

  def instructor_names
    name_array = [primary_instructor_name]
    name_array += instructors.map{|i| i.full_name}
    name_array.uniq.join(', ')
  end

  def primary_instructor_name
    primary_instructor ? primary_instructor.full_name : nil
  end

  def assignment_statuses(user=nil)
    fractions = {}
    assignments.each do |a|
      s = a.status(user).name
      fractions[s] ||= 0
      fractions[s] += a.fraction_of_grade
    end

    statuses = AssignmentStatus.all_statuses_ordered
    statuses.each do |s|
      s.fraction = fractions[s.name] || 0
    end
  end

  def root_lesson
    lessons.first
  end

  def lesson_tree
    root_lesson.descendant_tree if root_lesson
  end
end
