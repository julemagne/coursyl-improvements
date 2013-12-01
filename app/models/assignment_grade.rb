class AssignmentGrade < ActiveRecord::Base
  belongs_to :assignment
  belongs_to :course_student
  has_many :assignment_question_grades

  scope :graded, -> { where("graded_at IS NOT NULL") }

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
end
