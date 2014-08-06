class Meeting < ActiveRecord::Base
  belongs_to :course
  has_many :meeting_lessons, -> {order :order_number}, dependent: :destroy
  has_many :lessons, through: :meeting_lessons

  default_scope { order('held_at') }

  validates :held_at, presence: true
  validates :video_url, format: {with: /\Ahttps?:\/\//, message: "must start with http:// or https://"}, allow_blank: true

  delegate :code_and_name, to: :course, prefix: true

  after_update :update_all_lesson_activity_times
  after_destroy :update_nearby_lesson_activity_times

  def update_all_lesson_activity_times
    if held_at_changed?
      course.lessons.each {|l| l.update_activity_times}
    end
  end

  def update_nearby_lesson_activity_times
    if preceding_meeting
      preceding_meeting.lessons.each {|l| l.update_activity_times}
    end
    lessons.each {|l| l.update_activity_times}
    if next_meeting
      preceding_meeting.lessons.each {|l| l.update_activity_times}
    end
  end

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

  def preceding_meeting
    course.meetings.where("held_at < ?", held_at).order("held_at DESC").first
  end

  def preceding_meeting_held_at
    preceding_meeting ? preceding_meeting.held_at : course.term.starts_on
  end

  def next_meeting
    course.meetings.where("held_at > ?", held_at).order("held_at").first
  end

  def next_meeting_held_at
    next_meeting ? next_meeting.held_at : course.term.ends_on
  end
end
