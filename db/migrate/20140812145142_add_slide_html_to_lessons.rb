class AddSlideHtmlToLessons < ActiveRecord::Migration
  def change
    add_column :lessons, :slide_html, :text
  end
end
