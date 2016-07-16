FcApi::Engine.routes.draw do
  resources :main, only: [:index, :edit]
end
