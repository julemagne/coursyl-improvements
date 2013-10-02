class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :title
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.string :phone
      t.string :office
      t.string :office_hours
      t.string :photo_url
      t.text :description
      t.boolean :admin

      t.timestamps
    end
  end
end
