class CourseStudent < ActiveRecord::Base
  belongs_to :course
  belongs_to :student, class_name: "User"
  has_many :assignment_grades, dependent: :restrict_with_error

  validates :course, presence: true
  validates :student, presence: true
  validates :student, uniqueness: {scope: :course_id}

  scope :approved, -> { where(approved: true) }
  scope :unapproved, -> { where(approved: false) }

  delegate :code_and_name, :color, to: :course, prefix: true
  delegate :full_name, :first_name, :last_name, :email, to: :student

  def percent_graded
    assignment_grades.graded.sum {|ag| ag.percent_of_grade}
  end

  def current_grade
    #This method does not simply call percent_graded to get the total, as that
    #  would require performing the loop twice.
    weighted_total = 0
    percent_total = 0
    assignment_grades.graded.each do |ag|
      weighted_total += ag.grade * ag.percent_of_grade
      percent_total += ag.percent_of_grade
    end
    percent_total > 0 ? weighted_total/percent_total : 100
  end

  def grade
    final_grade || current_grade
  end

  def percent_graded
    assignment_grades.graded.sum {|ag| ag.percent_of_grade}
  end

  def letter_grade
    course.letter_for_grade(grade)
  end

  def max_grade
    (100-percent_graded) + min_grade
  end

  def min_grade
    current_grade*percent_graded/100
  end
end
