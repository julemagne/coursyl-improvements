class Assignment < ActiveRecord::Base
  belongs_to :course

  validates :active_at, presence: true
  validates :due_at, presence: true

  def status(user = nil)
    AssignmentStatus.new(assignment: self, user: user)
  end

end
