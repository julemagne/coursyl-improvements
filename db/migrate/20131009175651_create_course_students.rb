class CreateCourseStudents < ActiveRecord::Migration
  def change
    create_table :course_students do |t|
      t.integer :student_id
      t.integer :course_id
      t.float :final_grade

      t.timestamps
    end
  end
end
