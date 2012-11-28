class DocumentsController < ApplicationController

  rescue_from Document::FileRequiredForCreation, :with => :no_doc_on_create

  def index
    documents = Document.from_system(requesting_system)
    documents.joins(:tags).where('tags.name IN (?)', params[:tags].split(',')) if params[:tags].present?
    documents = documents.owned_by(params[:owner_id]) if params[:owner_id].present?
    respond_with documents
  end

  def show
    respond_with requesting_system.documents.find(params[:id])
  end

  def file
    document = requesting_system.documents.find(params[:document_id])
    send_file(document.file.path, :filename => document.filename, :type => document.content_type)
  end

  def create
    raise Document::FileRequiredForCreation unless params[:document][:file_as_base64].present?

    tags_param = params[:document].delete(:tags)

    document = Document.new(params[:document])
    document.source_system_id = requesting_system.id
    document.save

    document.add_tags(tags_param) unless tags_param.nil?

    respond_with document
  end

  def destroy
    respond_with requesting_system.documents.find(params[:id]).destroy
  end

  private

  def no_doc_on_create
    render_error 400, "File cannot be blank"
  end

end
