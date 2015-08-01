class Recording < ActiveRecord::Base
  
  ### Model Definition
  
  ### Associations
  has_one :author
  has_one	:timecode
  has_many	:segments
  has_one	:transcript
  
  has_many  :taggings, :as => :taggable
            
  has_many  :tags, :through => :taggings
  
  ### Validations
  
  ### Callbacks
  
  ### Instance Methods
  
  ### Paperclip
  has_attached_file :file, 
                    :processors => lambda{ |attachment|
                       attachment.check_processor_type
                    },
                    :default_url => "/recordings/:style/missing.png",
                    :path => ":id/:id_:style_:filename",
                    :convert_options => { :all => "-strip -colorspace RGB" },
                    :whiny => true,
                    :storage => :s3,
                    :s3_credentials => {
                                        :bucket => 'la_audio',
                                        :access_key_id => 'AKIAJTGQYJTFCNCCVHFQ',
                                        :secret_access_key => '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'  
                                        }         
                    
  validates_attachment_presence :file
  validates_attachment_content_type :file, :content_type => [/\Aaudio\/.*\Z/, /\Aapplication\/.*\Z/]  
end
