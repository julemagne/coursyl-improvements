class AssignmentQuestionGrade < ActiveRecord::Base
  belongs_to :assignment_question
  belongs_to :assignment_grade
end
