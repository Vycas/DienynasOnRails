class CreateCourses < ActiveRecord::Migration
  def self.up
    create_table :courses do |t|
      t.string :title, :null => false
      t.string :description
      t.string :time
      t.references :teacher, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :courses
  end
end
