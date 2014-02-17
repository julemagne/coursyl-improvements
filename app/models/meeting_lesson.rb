class MeetingLesson < ActiveRecord::Base
  belongs_to :meeting
  belongs_to :lesson
end
