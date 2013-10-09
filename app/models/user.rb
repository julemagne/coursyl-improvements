class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :course_instructors, foreign_key: "instructor_id"
  has_many :courses_taught, through: :course_instructors, source: :course
  has_many :assignments_given, through: :courses_taught, source: :assignments

  has_many :course_students, foreign_key: "student_id"
  has_many :courses_taken, through: :course_students, source: :course
  has_many :assignments_taken, through: :courses_taken, source: :assignments

  validates :title, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true

  def full_name
    "#{title} #{first_name} #{padded_middle_initial}#{last_name}"
  end

  def middle_initial
    middle_name ? middle_name.first : nil
  end

  def is_student?
    false
  end

  def is_instructor?
    course_instructors.length > 0
  end

  def is_admin?
    admin
  end

  private

  def padded_middle_initial
    middle_initial ? "#{middle_initial}. " : ""
  end
end
