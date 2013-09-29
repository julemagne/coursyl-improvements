require 'test_helper'

class AssignmentStatusTest < ActiveSupport::TestCase
  test "Assignments have been created from fixtures" do
    assert assignments(:project).fraction_of_grade == 0.5,
      "Project fraction not correct."
  end

  test "Assignment Statuses calculated correctly across a course" do
    as = courses(:intro).assignment_statuses
    assert as.first.name == "Complete"
    assert as.first.fraction == 0.5
    assert as.second.name == "In Progress"
    assert as.second.fraction == 0.3
    assert as.length == 4

  end
end
