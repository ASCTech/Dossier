class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :require_api_key

  respond_to :xml, :json

  rescue_from ActiveRecord::RecordNotFound, :with => :document_not_found
  rescue_from Document::NotAuthorized,      :with => :document_not_authorized

protected

  def requesting_system
    @source_system ||= SourceSystem.find_by_api_key(request.headers['x-api-key'] || params['api_key'])
  end

  def render_error(status, message)
    respond_to do |format|
      format.html { render :file => "#{Rails.root}/public/#{status}.html", :status => status, :layout => false }
      format.json { render :json => { :error => true, :message => message }, :status => status }
      format.xml  { render :xml  => { :error => true, :message => message }, :status => status }
    end
  end

  def require_api_key
    render_error 401, 'You do not have a valid API key' unless requesting_system
  end

  def document_not_authorized(exception)
    render_error 401, exception.message
  end

  def document_not_found
    render_error 404, "Document not found"
  end
end
