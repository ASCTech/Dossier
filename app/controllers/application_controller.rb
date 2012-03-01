class ApplicationController < ActionController::Base
  protect_from_forgery

protected

  def requesting_system
    SourceSystem.find_by_api_key(request.headers['x-api-key'])
  end

  def render_error(status, message)
    respond_to do |format|
      format.html { render :file => "#{Rails.root}/public/#{status}.html", :status => status, :layout => false }
      format.json { render :json => { :error => true, :message => message } }
      format.xml  { render :xml  => { :error => true, :message => message } }
    end
  end
end
