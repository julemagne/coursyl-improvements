class Lesson < ActiveRecord::Base
  belongs_to :course
  has_many :readings, dependent: :destroy
  has_many :child_lessons, -> {order :held_at}, class_name: "Lesson", foreign_key: "parent_lesson_id"
  belongs_to :parent_lesson, class_name: "Lesson", foreign_key: "parent_lesson_id"

  validates :name, presence: true

  accepts_nested_attributes_for :readings,
      :allow_destroy => true,
      :reject_if     => :all_blank

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

  def course_color
    course.color
  end

  def course_code_and_name
    course.code_and_name
  end

end
