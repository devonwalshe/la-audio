class CreateSegments < ActiveRecord::Migration
  def change
    create_table :segments do |t|
      t.integer :audio_id
      t.time :start_time
      t.time :end_time
      t.text :name
      t.text :description

      t.timestamps null: false
    end
  end
end
