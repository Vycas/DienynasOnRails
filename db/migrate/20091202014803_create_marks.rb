class CreateMarks < ActiveRecord::Migration
  def self.up
    create_table :marks do |t|
      t.string :value
      t.date :date
      t.references :attendance

      t.timestamps
    end
  end

  def self.down
    drop_table :marks
  end
end
