class CreateInscriptions < ActiveRecord::Migration
  def self.up
    create_table :inscriptions do |t|
      t.string :how
      t.integer :student_id
      t.integer :shift_id

      t.timestamps
    end
  end

  def self.down
    drop_table :inscriptions
  end
end
