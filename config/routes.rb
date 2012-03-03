Dossier::Application.routes.draw do

  resources :documents, :only => [:index, :show, :create, :destroy] do
    get 'file'
    resources :tags, :only => [:create, :destroy]
  end

end
