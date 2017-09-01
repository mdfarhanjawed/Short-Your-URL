Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :short_urls
  root to: "short_urls#index"

  get 'original', to: 'short_urls#original'
end
