class Document < ActiveRecord::Base

  belongs_to :source_system
  has_many :document_tags, :dependent => :destroy
  has_many :tags, :through => :document_tags

  mount_uploader :file, FileUploader

  def self.from_system(system)
    where(:source_system_id => system.id)
  end

  def from_system?(system)
    source_system == system
  end

  class NotAuthorized < StandardError; end

end
