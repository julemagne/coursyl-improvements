class CreateTerms < ActiveRecord::Migration
  def change
    create_table :terms do |t|
      t.string :name
      t.date :starts_on
      t.date :ends_on
      t.integer :school_id

      t.timestamps
    end

    add_column :courses, :term_id, :integer
  end
end
