class CreateAssignmentQuestionGrades < ActiveRecord::Migration
  def change
    create_table :assignment_question_grades do |t|
      t.integer :assignment_question_id
      t.integer :assignment_grade_id
      t.float :grade
      t.text :answer
      t.text :comments

      t.timestamps
    end
  end
end
