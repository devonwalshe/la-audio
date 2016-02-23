class Tag < ActiveRecord::Base
  ### Model Definition
  
  ### Associations
  has_many  :taggings
  has_many :children, class_name: "Tag", foreign_key: "parent_id"
  belongs_to :parent, class_name: "Tag"
  
  ### Validations
  
  ### Callbacks
  
  ### Instance Methods
  
end

# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  name       :text
#  tag_type   :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
