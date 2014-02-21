class AddReadingBeforeLesson < ActiveRecord::Migration
  def change
    add_column :readings, :before_lesson, :boolean, default: true
  end
end
