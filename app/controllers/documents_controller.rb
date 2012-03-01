class DocumentsController < ApplicationController

  before_filter :require_api_key

  respond_to :xml, :json

  rescue_from ActiveRecord::RecordNotFound, :with => :document_not_found

  def index
    respond_with Document.from_system(requesting_system)
  end

  def show
    @document = Document.find(params[:id])

    if @document.from_system? requesting_system
      respond_with @document
    else
      render_403 "#{requesting_system.name} does not have access to this document"
    end
  end

private

  def require_api_key
    return if requesting_system
    render_403 'You do not have a valid API key'
  end

  def document_not_found
    render_error 404, "Document with ID #{params[:id]} not found"
  end

end
