class Timecode < ActiveRecord::Base
  
  ### Model Definition
  
  ### Associations
  
  has_one	:recording
  
  ### Validations
  
  ### Callbacks
  
  ### Instance Methods
  
end

# == Schema Information
#
# Table name: timecodes
#
#  id         :integer          not null, primary key
#  start_time :time
#  end_time   :time
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
