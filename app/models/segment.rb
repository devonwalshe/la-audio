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
