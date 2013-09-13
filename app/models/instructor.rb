class Instructor < ActiveRecord::Base
  has_many :course_instructors
  has_many :courses, through: :course_instructors

  def full_name
    "#{title} #{first_name} #{padded_middle_initial}#{last_name}"
  end

  def middle_initial
    middle_name ? middle_name.first : nil
  end

  private

  def padded_middle_initial
    middle_initial ? "#{middle_initial}. " : ""
  end
end
