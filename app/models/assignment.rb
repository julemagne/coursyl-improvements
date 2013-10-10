class Assignment < ActiveRecord::Base
  belongs_to :course

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

end
