class DocumentsController < ApplicationController

  before_filter :require_api_key

  def index
    @documents = Document.where(:source_system_id => requesting_system.id)
    respond_to do |format|
      format.json { render :json => @documents }
      format.xml  { render :xml  => @documents }
    end
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
