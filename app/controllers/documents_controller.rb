class DocumentsController < ApplicationController

  before_filter :require_api_key

  respond_to :xml, :json

  def index
    respond_with Document.from_system(requesting_system)
  end

  def show
    respond_with Document.from_system(requesting_system).find(params[:id])
  end

private

  def require_api_key
    return if requesting_system
    render_403 'You do not have a valid API key'
  end

end
