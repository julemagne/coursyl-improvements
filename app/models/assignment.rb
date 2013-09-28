class Assignment < ActiveRecord::Base
  belongs_to :course

  def status(user = nil)
    AssignmentStatus.new(assignment: self, user: user)
  end

end
