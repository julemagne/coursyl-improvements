class Meeting < ActiveRecord::Base
  belongs_to :course
  has_many :meeting_lessons
end
