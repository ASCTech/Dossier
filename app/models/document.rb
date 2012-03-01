class Document < ActiveRecord::Base

  belongs_to :source_system
  has_many :document_tags
  has_many :tags, :through => :document_tags

end
