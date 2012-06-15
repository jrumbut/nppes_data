NppesData::Application.routes.draw do
  resources :providers do
    collection do
      get  :search
      post :results
    end
  end
  match "/npi/:npi" => 'providers#show'

  root :to => 'providers#search'
end
