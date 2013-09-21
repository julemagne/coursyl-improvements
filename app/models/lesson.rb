class Lesson < ActiveRecord::Base
  has_many :child_lessons, class_name: "Lesson", foreign_key: "parent_lesson_id"
  belongs_to :parent_lesson, class_name: "Lesson", foreign_key: "parent_lesson_id"

  # validates :name, presence: true

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
end
