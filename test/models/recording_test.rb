require 'test_helper'

class RecordingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

# == Schema Information
#
# Table name: recordings
#
#  id                :integer          not null, primary key
#  author_id         :integer
#  transcript_id     :integer
#  timecode_id       :integer
#  description       :text
#  image_url         :text
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  file_file_name    :string
#  file_content_type :string
#  file_file_size    :integer
#  file_updated_at   :datetime
#
