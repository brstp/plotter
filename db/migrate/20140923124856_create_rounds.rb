class CreateRounds < ActiveRecord::Migration
  def change
    create_table :rounds do |t|
      t.integer :boat_id
      t.integer :waypoint_id
      t.integer :position

      t.timestamps
    end
  end
end
