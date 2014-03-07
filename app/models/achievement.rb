class Achievement < ActiveRecord::Base
  belongs_to :course
  has_many :awarded_achievements, dependent: :destroy

  validates :course_id, presence: true
  validates :name, presence: true
  validates :points, presence: true

  default_scope { order('category, name') }

  delegate :code_and_name, to: :course, prefix: true

end