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
