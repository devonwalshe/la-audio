class CreateRecordings < ActiveRecord::Migration
  def change
    create_table :recordings do |t|

      t.integer :author_id
      t.integer :transcript_id
      t.integer :timecode_id
      t.text :description
      t.text :image_url

      t.timestamps null: false
    end
  end
end
