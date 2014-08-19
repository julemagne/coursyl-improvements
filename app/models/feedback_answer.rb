class FeedbackAnswer < ActiveRecord::Base
  belongs_to :course_student
  belongs_to :feedback_question
  belongs_to :meeting

  validates :course_student, presence: true
  validates :feedback_question, presence: true
  validates :meeting, presence: true
  validates :score, presence: true
end