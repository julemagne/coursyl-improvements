class Lesson < ActiveRecord::Base
  belongs_to :course
  has_many :child_lessons, class_name: "Lesson", foreign_key: "parent_lesson_id"
  belongs_to :parent_lesson, class_name: "Lesson", foreign_key: "parent_lesson_id"

  validates :name, presence: true

  def descendant_tree
    tree = {name: name,
      description: description,
      heldat: held_at_integer,
      contents: []}
    child_lessons.each do |l|
      tree[:contents] << l.descendant_tree
    end
    tree
  end

  def held_at_integer
    held_at.to_i
  end

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

  def can_be_answered?(user)
    lead_in_question? && Time.now < held_at.time - 1.hour && next_lesson? && user.enrolled?(course)
  end
end
