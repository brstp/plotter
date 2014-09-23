class CreateBoats < ActiveRecord::Migration
  def change
    create_table :boats do |t|
      t.string :name
      t.integer :period
      t.integer :start_number

      t.timestamps
    end
  end
end
