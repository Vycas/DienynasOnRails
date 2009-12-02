class CreateCourses < ActiveRecord::Migration
  def self.up
    create_table :courses do |t|
      t.string :title
      t.string :description
      t.string :time
      t.reference :teacher

      t.timestamps
    end
  end

  def self.down
    drop_table :courses
  end
end
