Dossier::Application.routes.draw do

  resources :documents, :only => [:index, :show, :create, :destroy, :update] do
    get 'file'
  end

  match 'owners/:owner_id/documents', :controller => :documents, :action=> :index

end
