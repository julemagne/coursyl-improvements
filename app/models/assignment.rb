class Assignment < ActiveRecord::Base
  belongs_to :course
  has_many :assignment_questions, -> {order :order_number}
  has_many :assignment_grades

  validates :course_id, presence: true
  validates :name, presence: true
  validates :active_at, presence: true
  validates :due_at, presence: true

  scope :active, -> { where("active_at <= ? AND due_at >= ?", Time.now, Time.now) }
  scope :recent_and_soon, -> { where("active_at <= ? AND due_at >= ?", Time.now+1.month, Time.now-2.week) }

  def status(user = nil)
    AssignmentStatus.new(assignment: self, user: user)
  end

  def course_code_and_name
    course.code_and_name
  end

  def course_color
    course.color
  end

  def turn_in(answers, user)
    if user && user.enrolled?(course) && status(user).overdue_or_in_progress?
      course_student = CourseStudent.where(student: user, course_id: @assignment.course).first
      assignment_grade = AssignmentGrade.where(assignment: @assignment,
        course_student: course_student,
        submitted_at: Time.now).first_or_create!

      answers.each do |k,v|
        AssignmentQuestionGrade.create!(assignment_question_id: k.to_i,
          assignment_grade: assignment_grade,
          answer: v)
      end

      assignment_grade
    end
  end

end
