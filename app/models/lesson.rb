class Lesson < ActiveRecord::Base
  belongs_to :course
  has_many :meeting_lessons
  has_many :meetings, -> {order :held_at}, through: :meeting_lessons
  has_many :readings, dependent: :destroy
  has_many :child_lessons, -> {order :id}, class_name: "Lesson", foreign_key: "parent_lesson_id"
  belongs_to :parent_lesson, class_name: "Lesson", foreign_key: "parent_lesson_id"

  validates :name, presence: true

  accepts_nested_attributes_for :readings,
      :allow_destroy => true,
      :reject_if     => :all_blank

  scope :roots, -> { where("parent_lesson_id IS NULL") }

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
    meetings.first.held_at_integer
  end

  def course_color
    course.color
  end

  def course_code_and_name
    course.code_and_name
  end

  def parent_name
    parent_lesson.name
  end

end
