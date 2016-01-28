class FixSegmentColumnAudioId < ActiveRecord::Migration
  
  def self.up
    rename_column :segments, :audio_id, :recording_id
    change_column :segments, :start_time, :string
    change_column :segments, :end_time, :string
  end

  def self.down
    rename_column :segments, :recording_id, :audio_id
    change_column :segments, :start_time, :time
    change_column :segments, :end_time, :time
    
  end
end
