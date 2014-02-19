class Meeting < ActiveRecord::Base
  belongs_to :course
  has_many :meeting_lessons, -> {order :order_number}
  has_many :lessons, through: :meeting_lessons

  validates :held_at, presence: true

  def in_past?
    held_at < Time.now
  end

  def next_lesson?
    self == course.next_lesson
  end

  def in_future?
    held_at > Time.now
  end

  def past_or_next?
    in_past? || next_lesson?
  end

  def lesson_names
    lessons.map(&:name).join(', ')
  end

  def held_at_integer
    held_at.to_i
  end
end
