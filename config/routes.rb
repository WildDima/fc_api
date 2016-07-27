FcApi::Engine.routes.draw do
  resources :main, only: [:index, :edit]
  namespace :api, defaults: { format: :json } do
    namespace :v1, defaults: { format: :json } do
      resources :cards, except: [:new, :edit]
      put 'review_card' => 'trainer#review_card'
    end
  end
end
