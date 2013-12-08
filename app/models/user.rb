class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :course_instructors, foreign_key: "instructor_id"
  has_many :courses_taught, through: :course_instructors, source: :course
  has_many :assignments_given, through: :courses_taught, source: :assignments

  has_many :course_students, foreign_key: "student_id"
  has_many :courses_taken, through: :course_students, source: :course
  has_many :assignments_taken, through: :courses_taken, source: :assignments

  has_many :assignment_grades, through: :course_students
  has_many :assignment_question_grades, through: :assignment_grades

  validates :first_name, presence: true
  validates :last_name, presence: true

  def full_name
    "#{title + " " if title}#{first_name} #{padded_middle_initial}#{last_name}"
  end

  def middle_initial
    middle_name ? middle_name.first : nil
  end

  def is_student?
    false
  end

  def is_instructor?
    course_instructors.length > 0
  end

  def is_admin?
    admin
  end

  def enrolled?(course)
    courses_taken.include?(course)
  end

  def teaching?(course)
    courses_taught.include?(course)
  end

  def grade(course)
    course_students.where(course_id: course.id).first.grade
  end

  def grade_on_assignment(assignment)
    ag = assignment_grades.graded.where(assignment: assignment).first
    ag.grade if ag
  end

  def grade_on_question(question)
    agq = assignment_question_grades.where("assignment_questions.id" => question.id).first
    agq.grade if agq
  end

  def letter_grade(course)
    course_students.where(course_id: course.id).first.letter_grade
  end

  def min_grade(course)
    course_students.where(course_id: course.id).first.min_grade
  end

  def max_grade(course)
    course_students.where(course_id: course.id).first.max_grade
  end

  def fraction_graded(course)
    course_students.where(course_id: course.id).first.fraction_graded
  end

  def completed_assignment?(assignment)
    assignment_grades.where(["assignment_id = ? AND submitted_at IS NOT NULL", assignment.id]).exists?
  end

  def overdue_assignment?(assignment)
    overdue_assignments.include?(assignment)
  end

  def overdue_assignments
    assignments_taken.select {|a| a.due_at < Time.now &&
      assignment_grades.where(["assignment_id = ? AND submitted_at IS NOT NULL", a.id]).blank? }
  end

  def overdue_or_active_assignments
    overdue_assignments + assignments_taken.active
  end

  private

  def padded_middle_initial
    middle_initial ? "#{middle_initial}. " : ""
  end
end
