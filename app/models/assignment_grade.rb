class AssignmentGrade < ActiveRecord::Base
  belongs_to :assignment
  belongs_to :course_student
  has_many :assignment_question_grades, dependent: :restrict

  scope :graded, -> { joins(:assignment).where("assignments.grades_released IS TRUE") }

  delegate :course, to: :assignment

  def fraction_of_grade
    assignment.fraction_of_grade
  end

  def answer_on(question)
    aqg = assignment_question_grades.where(assignment_question: question).first
    aqg && !aqg.answer.blank? ? aqg.answer : nil
  end

  def grade_on(question)
    aqg = assignment_question_grades.where(assignment_question: question).first
    aqg ? aqg.grade : nil
  end

  def comments_on(question)
    aqg = assignment_question_grades.where(assignment_question: question).first
    aqg && !aqg.comments.blank? ? aqg.comments : nil
  end

  def current_grade
    grade_total = 0
    assignment_question_grades.each do |aqg|
      grade_total += aqg.grade.to_f
    end
    grade_total
  end

  def grade
    [(final_grade || current_grade), assignment.maximum_grade].compact.min
  end

  def letter_grade
    course.letter_for_grade(grade)
  end
end
