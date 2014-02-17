class CreateMeetingLessons < ActiveRecord::Migration
  def change
    create_table :meeting_lessons do |t|
      t.integer :meeting_id
      t.integer :lesson_id
      t.integer :order_number

      t.timestamps
    end
  end
end
