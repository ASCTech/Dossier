class DocumentsController < ApplicationController

  before_filter :require_api_key

  respond_to :xml, :json

  rescue_from ActiveRecord::RecordNotFound, :with => :document_not_found
  rescue_from Document::NotAuthorized,      :with => :document_not_authorized

  def index
    documents = Document.from_system(requesting_system)
    if params[:tags].present?
      tag_names_and_ids = params[:tags].split(',')
      tag_ids   = tag_names_and_ids.map(&:to_i).reject{|e| e == 0}.uniq
      tag_names = tag_names_and_ids.reject{|e| e =~ /[^\D]/}.uniq
      if params[:operator] =~ /^or$/i
        tags = Tag.where('id IN (?) OR name IN (?)', tag_ids, tag_names)
        document_ids = DocumentTag.where(:tag_id => tags).pluck(:document_id).uniq
        documents = documents.where(:id => document_ids)
      else
        named_tags = Tag.find_all_by_name(tag_names)
        raise ActiveRecord::RecordNotFound unless named_tags.size == tag_names.size
        tags = Tag.find(tag_ids) + named_tags
        tags.each do |tag|
          documents = documents.has_tag(tag)
        end
      end
    end
    if params[:owner_id].present?
      documents = documents.owned_by(params[:owner_id])
    end
    respond_with documents
  end

  def show
    respond_with requesting_system.get_document(params[:id])
  end

  def file
    doc_file = requesting_system.get_document(params[:document_id]).file
    send_file(doc_file.current_path, :filename => doc_file.identifier)
  end

  def create
    document = Document.create(params[:document].merge({ :source_system_id => requesting_system.id }))
    document.add_tags(params[:tags]) if params[:tags].present?
    respond_with document
  end

  def destroy
    respond_with requesting_system.get_document(params[:id]).destroy
  end

private

  def require_api_key
    return if requesting_system
    render_error 401, 'You do not have a valid API key'
  end

  def document_not_found
    render_error 404, "Document with ID #{params[:id]} not found"
  end

  def document_not_authorized(exception)
    render_error 401, exception.message
  end

end
