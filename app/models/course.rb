class Course < ActiveRecord::Base
  has_many :assignments, -> {order :due_at}
  has_many :lessons, -> {order :held_at}
  has_many :policies, -> {order :order_number}
  has_many :course_instructors
  has_many :instructors, through: :course_instructors

  has_one :primary_course_instructor, -> {where primary: true},
    class_name: "CourseInstructor"
  has_one :primary_instructor, through: :primary_course_instructor, source: :instructor

  def instructor_names
    name_array = [primary_instructor_name]
    name_array += instructors.map{|i| i.full_name}
    name_array.uniq.join(', ')
  end

  def primary_instructor_name
    primary_instructor ? primary_instructor.full_name : nil
  end

  def completion_fractions(user=nil)
    percentages = {"Complete" => 0,
      "In Progress" => 0,
      "Overdue" => 0,
      "Future" => 0}
    assignments.each do |a|
      percentages[a.status(user)] += a.fraction_of_grade
    end
    percentages
  end

  def root_lesson
    lessons.first
  end

  def lesson_tree
    if root_lesson
      root_lesson.descendant_tree
    else
      nil
    end
  end
end
