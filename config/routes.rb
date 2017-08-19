Rails.application.routes.draw do
  resources :posts
  root 'welcome#index'

  resources :posts do
    resources :comments
  end
  
  get "posts/like/:id" => "posts#like"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
