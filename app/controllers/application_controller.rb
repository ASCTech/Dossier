class ApplicationController < ActionController::Base
  protect_from_forgery

protected

  def requesting_system
    SourceSystem.find_by_api_key(request.headers['x-api-key'])
  end

  def render_403(message='')
    message = 'Not authorized' if message.empty?
    respond_to do |format|
      format.html { render :file => "#{Rails.root}/public/403.html", :status => 403, :layout => false }
      format.json { render :json => { :error => true, :message => message } }
      format.xml  { render :xml  => { :error => true, :message => message } }
    end
  end

  def render_404(message='')
    message = 'Resource not found' if message.empty?
    respond_to do |format|
      format.html { render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false }
      format.json { render :json => { :error => true, :message => message } }
      format.xml  { render :xml  => { :error => true, :message => message } }
    end
  end

end
