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

  def serializable_hash(options=nil)
    options = {} if options.nil?
    options[:except] = :file
    options[:include] = :tags
    options[:methods] = :all_tags
    super options
  end

  def all_tags
    tags.map(&:name)
  end

  class NotAuthorized < StandardError; end

end
