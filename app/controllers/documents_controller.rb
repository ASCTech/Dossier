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
    respond_to do |format|
      format.html { render :file => "#{Rails.root}/public/403.html", :status => 403, :layout => false }
      format.json { render :json => { :error => true, :message => "Error 403, you are not authorized to access Dossier." } }
      format.xml  { render :xml  => { :error => true, :message => "Error 403, you are not authorized to access Dossier." } }
    end
  end

end
