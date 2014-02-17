class Course < ActiveRecord::Base
  has_many :assignments, -> {order :due_at}, dependent: :destroy
  has_many :lessons, -> {order :held_at}, dependent: :destroy
  has_many :policies, -> {order :order_number}, dependent: :destroy
  has_many :course_students, dependent: :restrict_with_error
  has_many :students, through: :course_students
  has_many :course_instructors, dependent: :destroy, inverse_of: :course
  has_many :instructors, through: :course_instructors
  has_many :grade_thresholds, -> {order "grade DESC"}

  has_one :primary_course_instructor, -> {where primary: true},
    class_name: "CourseInstructor"
  has_one :primary_instructor, through: :primary_course_instructor, source: :instructor

  belongs_to :term

  validates :name, presence: true
  validates :course_code, presence: true

  accepts_nested_attributes_for :course_instructors,
      allow_destroy: true,
      reject_if: proc { |attributes| attributes['instructor_id'].blank? }

  accepts_nested_attributes_for :policies,
      allow_destroy: true,
      reject_if: :all_blank

  accepts_nested_attributes_for :grade_thresholds,
      allow_destroy: true,
      reject_if: :all_blank

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

    statuses = AssignmentStatus.all_statuses_ordered(user && user.teaching?(self), user && user.enrolled?(self))
    statuses.each do |s|
      s.fraction = fractions[s.name] || 0
    end
  end

  def last_assignment
    assignments.where(["due_at <= ?", Time.now]).last
  end

  def next_assignment
    assignments.where(["due_at > ?", Time.now]).first
  end

  def root_lesson
    lessons.first
  end

  def next_lesson
    lessons.where(['held_at > ?', Time.now]).order('held_at ASC').first
  end

  def lesson_tree
    root_lesson.descendant_tree if root_lesson
  end

  def fraction_elapsed
    return 0 if lessons.blank? && assignments.blank?

    start_time = (lessons.present? ? lessons.first.held_at : assignments.first.active_at)
    end_time = (assignments.present? ? assignments.last.due_at : lessons.last.held_at)

    [[(Time.now-start_time)/(end_time-start_time), 0].max, 1].min
  end

  def letter_for_grade(grade)
    grade_thresholds.where(["grade <= ?", grade]).first.letter
  end
end
