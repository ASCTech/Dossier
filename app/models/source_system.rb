class SourceSystem < ActiveRecord::Base

  has_many :documents

  def get_document(id)
    doc = Document.find(id)
    raise Document::NotAuthorized.new("#{name} is not authorized to view this document") unless doc.from_system? self
    doc
  end

end
