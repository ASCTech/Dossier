Dossier::Application.routes.draw do

  resources :documents, :only => [:index, :show, :create] do
    get 'file'
  end

end
