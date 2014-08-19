class TimeCard < ActiveRecord::Base
  belongs_to :course_student

  validates :course_student, presence: true
  validates :started_at, presence: true

  scope :open, -> { where(ended_at: true).where("started_at > ?", Time.now.beginning_of_day) }
  scope :completed, -> { where("ended_at IS NOT NULL") }
  scope :completed_this_week, -> { where("ended_at BETWEEN ? AND ?", Time.now.beginning_of_week, Time.now.end_of_week)}

  def duration_in_minutes
    ended_at.blank? ? 0 : ((ended_at - started_at)/60).ceil
  end
end
