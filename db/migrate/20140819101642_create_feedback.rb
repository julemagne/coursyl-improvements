class CreateFeedback < ActiveRecord::Migration
  def change
    create_table :feedback_questions do |t|
      t.integer :course_id
      t.integer :order_number
      t.string :question
      t.timestamps
    end
    create_table :feedback_answers do |t|
      t.integer :feedback_question_id
      t.integer :course_student_id
      t.integer :meeting_id
      t.integer :score
      t.timestamps
    end
    add_column :courses, :use_course_feedback, :boolean
  end
end
