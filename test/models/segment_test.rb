require 'test_helper'

class SegmentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

# == Schema Information
#
# Table name: segments
#
#  id          :integer          not null, primary key
#  audio_id    :integer
#  start_time  :time
#  end_time    :time
#  name        :text
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
