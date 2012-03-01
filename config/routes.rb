Dossier::Application.routes.draw do

  resources :documents, :only => [:index]

end
