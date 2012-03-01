class ApplicationController < ActionController::Base
  protect_from_forgery

protected

  def requesting_system
    SourceSystem.find_by_api_key(request.headers['x-api-key'])
  end

end
