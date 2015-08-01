class AddAttachmentFileToRecordings < ActiveRecord::Migration
  def self.up
    change_table :recordings do |t|
      t.attachment :file
    end
  end

  def self.down
    remove_attachment :recordings, :file
  end
end
