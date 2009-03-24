class CreateShifts < ActiveRecord::Migration
  def self.up
    create_table :shifts do |t|
      t.string :time
      t.integer :vacants
      t.integer :course_id
      t.integer :teacher_id

      t.timestamps
    end
  end

  def self.down
    drop_table :shifts
  end
end
