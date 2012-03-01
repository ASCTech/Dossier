class DocumentsController < ApplicationController

  before_filter :require_api_key

  respond_to :xml, :json

  rescue_from ActiveRecord::RecordNotFound, :with => :document_not_found
  rescue_from Document::NotAuthorized,      :with => :document_not_authorized

  def index
    respond_with Document.from_system(requesting_system)
  end

  def show
    respond_with requesting_system.get_document(params[:id])
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
