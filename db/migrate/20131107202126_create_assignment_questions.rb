class CreateAssignmentQuestions < ActiveRecord::Migration
  def change
    create_table :assignment_questions do |t|
      t.integer :assignment_id
      t.text :question
      t.integer :points
      t.integer :order_number

      t.timestamps
    end
  end
end
