class MoveLessonTimes < ActiveRecord::Migration
  def self.up
    Lesson.all.each do |l|
      m = Meeting.create!(held_at: l.held_at || Time.now, course_id: l.course_id, video_url: l.video_url)
      ml = MeetingLesson.create!(lesson_id: l.id, meeting_id: m.id, order_number: 1)
    end

    remove_column :lessons, :held_at, :datetime
    remove_column :lessons, :video_url, :text
  end

  def self.down
    add_column :lessons, :held_at, :datetime
    add_column :lessons, :video_url, :text

    MeetingLesson.all.each do |ml|
      ml.lesson.update_attributes!(held_at: ml.meeting.held_at, video_url: ml.meeting.video_url)
      ml.destroy
    end
    Meeting.all.each {|m| m.destroy}
  end
end
