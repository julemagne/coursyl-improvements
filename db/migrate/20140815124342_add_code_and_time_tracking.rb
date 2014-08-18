class AddCodeAndTimeTracking < ActiveRecord::Migration
  def change
    add_column :users, :code, :string

    create_table :time_cards do |t|
      t.integer :course_student_id
      t.datetime :started_at
      t.datetime :ended_at
      t.timestamps
    end

    add_column :courses, :use_time_cards, :boolean
    add_column :courses, :use_daily_questions, :boolean
    add_column :courses, :use_reveal_slides, :boolean
    add_column :courses, :use_meeting_video, :boolean
  end
end
