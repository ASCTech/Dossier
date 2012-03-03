Dossier::Application.routes.draw do

  resources :documents, :only => [:index, :show, :create, :destroy] do
    get 'file'
    match 'owner/:owner_id', :action=> :index, :on => :collection
    resources :tags, :only => [:create, :destroy]
  end

end
