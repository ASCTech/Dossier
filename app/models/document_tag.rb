class DocumentTag < ActiveRecord::Base

  belongs_to :document
  belongs_to :tag

  validates_uniqueness_of :tag_id, :scope => :document_id

end
