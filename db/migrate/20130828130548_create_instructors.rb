class CreateInstructors < ActiveRecord::Migration
  def change
    create_table :instructors do |t|
      t.string :title
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.string :email
      t.string :photo_url
      t.text :description

      t.timestamps
    end
  end
end
