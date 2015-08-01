class CreateTranscripts < ActiveRecord::Migration
  def change
    create_table :transcripts do |t|
      t.text :body
      t.integer :audio_id

      t.timestamps null: false
    end
  end
end
