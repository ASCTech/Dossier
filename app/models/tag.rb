class Tag < ActiveRecord::Base

  has_many :document_tags
  has_many :documents, :through => :document_tags

  validates_format_of :name, :with => /[\D]/

end
