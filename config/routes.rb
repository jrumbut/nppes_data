NppesData::Application.routes.draw do
  resources :providers do
    collection do
      get  :search
      post :results
    end
  end

  root :to => 'providers#search'
end
