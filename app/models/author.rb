class Author < ActiveRecord::Base
  
  ### Model Definition
  
  ### Associations
  
  has_many	:recordings
  has_many  :taggings, :as => :taggable
            
  has_many  :tags, :through => :taggings
  
  ### Validations
  
  ### Callbacks
  
  ### Instance Methods
  
  
  
end
