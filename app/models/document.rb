class Document < ActiveRecord::Base

  class NotAuthorized < StandardError; end

  belongs_to :source_system
  has_many :document_tags, :dependent => :destroy
  has_many :tags, :through => :document_tags

  mount_uploader :file, FileUploader

  attr_accessor :file_content

  before_validation :write_file

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

  def file_as_base64=(file_source)
    @file_content = file_source
  end

  private

  def write_file
    unless @file_content.nil?
      tmpfile = Tempfile.new('upload', Rails.root.join('tmp'), :encoding => 'BINARY')
      begin
        tmpfile.write(Base64.decode64(@file_content.force_encoding("BINARY")))
        wave_file = CarrierWave::SanitizedFile.new(tmpfile)
        wave_file.content_type = self.content_type
        self.file = wave_file
      ensure
        tmpfile.close!
      end
    end
  end

end
