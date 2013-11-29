class AssignmentGrade < ActiveRecord::Base
  belongs_to :assignment
  belongs_to :course_student

  scope :graded, -> { where("graded_at IS NOT NULL") }

  def fraction_of_grade
    assignment.fraction_of_grade
  end
end
