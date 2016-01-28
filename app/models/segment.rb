class Segment < ActiveRecord::Base
  
  ### Model Definition
  
  ### Associations
  
  has_one	:recording
  has_one :timecode, through:	:recording
  has_many  :taggings, :as => :taggable
            
  has_many  :tags, :through => :taggings
  
  ### Validations
  
  ### Callbacks
  
  ### Instance Methods
  
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
