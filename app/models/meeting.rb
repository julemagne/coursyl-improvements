class Meeting < ActiveRecord::Base
  belongs_to :course
  has_many :meeting_lessons, -> {order :order_number}, dependent: :destroy
  has_many :lessons, through: :meeting_lessons

  default_scope { order('held_at') }

  validates :held_at, presence: true
  validates :video_url, format: {with: /\Ahttps?:\/\//, message: "must start with http:// or https://"}, allow_blank: true

  delegate :code_and_name, to: :course, prefix: true

  def in_past?
    held_at < Time.now
  end

  def next_meeting?
    self == course.next_meeting
  end

  def in_future?
    held_at > Time.now
  end

  def past_or_next?
    in_past? || next_meeting?
  end

  def lesson_names
    lessons.map(&:name).join(', ')
  end

  def held_at_integer
    held_at.to_i
  end
end
