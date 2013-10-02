class User < ActiveRecord::Base
  has_many :course_instructors
  has_many :courses, through: :course_instructors

  validates :title, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true


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
