class CreateTimecodes < ActiveRecord::Migration
  def change
    create_table :timecodes do |t|
      t.time :start_time
      t.time :end_time

      t.timestamps null: false
    end
  end
end
