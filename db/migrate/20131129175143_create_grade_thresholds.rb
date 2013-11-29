class CreateGradeThresholds < ActiveRecord::Migration
  def change
    create_table :grade_thresholds do |t|
      t.integer :course_id
      t.float :grade
      t.string :letter

      t.timestamps
    end
  end
end
