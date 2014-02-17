class MoveLessonTimes < ActiveRecord::Migration
  def self.up
    Lesson.all.each do |l|
      m = Meeting.create!(held_at: l.held_at, course_id: l.course_id)
      ml = MeetingLesson.create!(lesson_id: l.id, meeting_id: m.id, order_number: 1)
    end

    remove_column :lessons, :held_at, :datetime
  end

  def self.down
    add_column :lessons, :held_at, :datetime

    MeetingLesson.all.each do |ml|
      ml.lesson.update_attributes!(held_at: ml.meeting.held_at)
      ml.destroy
    end
    Meeting.all.each {|m| m.destroy}
  end
end
