class MeetingLesson < ActiveRecord::Base
  belongs_to :meeting
  belongs_to :lesson

  validates :meeting, presence: true
  validates :lesson, presence: true

  def lesson_name
    lesson.name
  end
end
