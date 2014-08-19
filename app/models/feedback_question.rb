class FeedbackQuestion < ActiveRecord::Base
  belongs_to :course
  has_many :feedback_answers, dependent: :destroy

  validates :course, presence: true
  validates :order_number, presence: true
  validates :question, presence: true
end

