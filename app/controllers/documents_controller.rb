class DocumentsController < ApplicationController

  before_filter :require_api_key

  respond_to :xml, :json

  rescue_from ActiveRecord::RecordNotFound, :with => :document_not_found
  rescue_from Document::NotAuthorized,      :with => :document_not_authorized

  def index
    documents = Document.from_system(requesting_system)
    if params[:tags].present?
      tag_names_and_ids = params[:tags].split(',')
      tags = Tag.where(:id => tag_names_and_ids) + Tag.where(:name => tag_names_and_ids)
      document_ids = DocumentTag.where(:tag_id => tags).pluck(:document_id).uniq
      documents = documents.where(:id => document_ids)
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

  def owner
    respond_with Document.from_system(requesting_system).where(:owner_id => params[:owner_id])
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
