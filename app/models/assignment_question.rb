class AssignmentQuestion < ActiveRecord::Base
  belongs_to :assignment
  has_many :assignment_question_grades
end
