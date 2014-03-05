class AssignmentQuestionGrade < ActiveRecord::Base
  belongs_to :assignment_question
  belongs_to :assignment_grade

  scope :submitted, -> { joins(:assignment_grade).where("assignment_grades.submitted_at IS NOT NULL") }

  delegate :full_name, to: :assignment_grade
end
