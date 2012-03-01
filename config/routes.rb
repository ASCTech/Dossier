Dossier::Application.routes.draw do

  resources :documents, :only => [:index, :show, :create, :destroy] do
    get 'file'
    match 'owner/:owner_id', :action => :owner, :on => :collection
  end

end
