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

  def add_tags(string_of_tags)
    string_of_tags.split(',').each do |tag_name|
      document_tags.create!(:tag_id => Tag.find_or_create_by_name(tag_name).id)
    end
  end

  def self.has_tag(tag)
    where(:id => DocumentTag.where(:tag_id => tag.id).pluck(:document_id))
  end

  def self.owned_by(oid)
    where(:owner_id => oid)
  end

  class NotAuthorized < StandardError; end

end
