class AddCachedTagsToRecording < ActiveRecord::Migration
  def change
    add_column :recordings, :cached_tags, :string
  end
end
