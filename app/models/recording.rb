class Recording < ActiveRecord::Base
  include PgSearch
  pg_search_scope :search_tags, :associated_against => {
    :tags => :name
  }
  # pg_search_scope :search_tags, :associated_against => {
  #   :tags => :name
  # }
  
  
  ### Model Definition
  
  ### Associations
  belongs_to :author
  has_one	:timecode
  has_many	:segments
  has_one	:transcript
  
  has_many  :taggings, :as => :taggable
            
  has_many  :tags, :through => :taggings
  
  ### Validations
  
  ### Callbacks
  
  ### Instance Methods
  def tags_string
    self.tags.collect{|t| t.name}.join(", ")
  end
  
  ### Paperclip
  has_attached_file :file, 
                    :default_url => "/recordings/:style/missing.png",
                    :path => "/recordings/:id/:filename",
                    :whiny => true,
                    :storage => :s3,
                    :s3_credentials => {
                                        :bucket => 'la-audio',
                                        :access_key_id => 'AKIAIPD7A7XBPDOZRZJA',
                                        :secret_access_key => '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'  
                                        }         
                    
  validates_attachment_presence :file
  validates_attachment_content_type :file, :content_type => [/\Aaudio\/.*\Z/, /\Aapplication\/.*\Z/]  
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
