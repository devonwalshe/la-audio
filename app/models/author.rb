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

# == Schema Information
#
# Table name: authors
#
#  id              :integer          not null, primary key
#  image_url       :text
#  bio_text        :text
#  name            :text
#  job_title       :text
#  job_description :text
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
