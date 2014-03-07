class AwardedAchievement < ActiveRecord::Base
  belongs_to :achievement
  belongs_to :course_student

  validates :achievement_id, presence: true
  validates :course_student_id, presence: true

  scope :awarded, -> { where(awarded: true) }
end