class DocumentsController < ApplicationController

  def index
    documents = Document.from_system(requesting_system)

    if params[:tags].present?
      tag_names = params[:tags].split(',')

      if params[:operator] =~ /^or$/i
        documents.joins(:tags).where('tags.name IN (?)', tag_names)
      else
        tags = Tag.find_all_by_name(tag_names)
        raise ActiveRecord::RecordNotFound unless tags.size == tag_names.size
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

end
