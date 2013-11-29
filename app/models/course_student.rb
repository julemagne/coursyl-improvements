class CourseStudent < ActiveRecord::Base
  belongs_to :course
  belongs_to :student, class_name: "User"
  has_many :assignment_grades

  def fraction_graded
    assignment_grades.graded.sum {|ag| ag.fraction_of_grade}
  end

  def current_grade
    #This method does not simply call fraction_graded to get the total, as that
    #  would require performing the loop twice.
    weighted_total = 0
    fraction_total = 0
    assignment_grades.graded.each do |ag|
      weighted_total += ag.final_grade * ag.fraction_of_grade
      fraction_total += ag.fraction_of_grade
    end
    weighted_total/fraction_total
  end

  def grade
    final_grade || current_grade
  end

  def fraction_graded
    assignment_grades.graded.sum {|ag| ag.fraction_of_grade}
  end

  def letter_grade
    course.letter_for_grade(grade)
  end

  def max_grade
    100 - (100-current_grade)*fraction_graded
  end

  def min_grade
    current_grade*fraction_graded
  end
end
