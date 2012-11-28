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
        documents.joins(:tags).where('tags.id IN (?) OR tags.name IN (?)', tag_ids, tag_names)
      else
        named_tags = Tag.find_all_by_name(tag_names)
        raise ActiveRecord::RecordNotFound unless named_tags.size == tag_names.size

        id_tags = Tag.find(tag_ids)
        raise ActiveRecord::RecordNotFound unless id_tags.size == tag_ids.size

        tags = id_tags + named_tags
        documents = documents.has_tags(tags)
      end

    end
    
    documents = documents.owned_by(params[:owner_id]) if params[:owner_id].present?

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
    tags_param = params[:document].delete(:tags)
    params[:document].merge!({:content_type => params[:document][:file].content_type, :filename => params[:document][:file].original_filename }) if params[:document][:file].present?
    document = Document.create(params[:document].merge({ :source_system_id => requesting_system.id }))
    document.add_tags(tags_param) unless tags_param.nil?
    respond_with document
  end

  def destroy
    respond_with requesting_system.get_document(params[:id]).destroy
  end

private

  def require_api_key
    render_error 401, 'You do not have a valid API key' unless requesting_system
  end

  def document_not_found
    render_error 404, "Document with ID #{params[:id]} not found"
  end

  def document_not_authorized(exception)
    render_error 401, exception.message
  end

end
