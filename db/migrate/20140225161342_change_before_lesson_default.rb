class ChangeBeforeLessonDefault < ActiveRecord::Migration
  def self.up
    change_column :readings, :before_lesson, :boolean, default: false
  end
  def self.down
    change_column :readings, :before_lesson, :boolean, default: true
  end
end
