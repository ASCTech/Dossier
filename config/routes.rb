Dossier::Application.routes.draw do

  resources :documents, :only => [:index, :show] do
    get 'file'
  end

end
