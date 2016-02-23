class Author < ActiveRecord::Base
  ### Search declarations
  include PgSearch
  #Scope search
  pg_search_scope :search_tags, :associated_against => {
    :tags => :name
  }
  #Multisearch
  multisearchable :against => [:name, :bio_text, :job_title, :job_description]
  
  
  ### Model Definition
  
  ### Associations
  has_many	:recordings
  has_many  :taggings, :as => :taggable
            
  has_many  :tags, :through => :taggings
  has_many :tags, :through => :recordings
  
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
