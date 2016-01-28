class Transcript < ActiveRecord::Base
  
  ### Model Definition
  
  ### Associations
  
  has_one	:recording
  has_one :author, through:	:recording
  has_many  :taggings, :as => :taggable        
  has_many  :tags, :through => :taggings
  
  ### Validations
  
  ### Callbacks
  
  ### Instance Methods
  
end

# == Schema Information
#
# Table name: transcripts
#
#  id         :integer          not null, primary key
#  body       :text
#  audio_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
