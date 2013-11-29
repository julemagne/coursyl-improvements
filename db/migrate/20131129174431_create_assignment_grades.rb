class CreateAssignmentGrades < ActiveRecord::Migration
  def change
    create_table :assignment_grades do |t|
      t.integer :assignment_id
      t.integer :course_student_id
      t.float :final_grade
      t.datetime :submitted_at
      t.datetime :graded_at
      t.text :comments

      t.timestamps
    end
  end
end
