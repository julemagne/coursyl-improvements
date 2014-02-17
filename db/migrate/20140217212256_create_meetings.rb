class CreateMeetings < ActiveRecord::Migration
  def change
    create_table :meetings do |t|
      t.integer :course_id
      t.datetime :held_at

      t.timestamps
    end
  end
end
