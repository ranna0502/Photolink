Rails.application.routes.draw do
# エンドユーザー用
# URL /users/sign_in ...
devise_for :users,skip: [:passwords], controllers: {
registrations: "public/registrations",
sessions: 'public/sessions'
}

devise_scope :user do
  post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
end

#エンドユーザー側ルーティング
scope module: :public do

  resources :chat_rooms, only: [:create, :show]
  resources :notifications, only: [:index]
  get '/activity_points' => 'activity_points#search'
  resources :activity_points, only: [:new, :create, :show, :edit, :update, :destroy]

  get 'users/info' => 'users#info'
  get 'users/matchings' => 'users#matchings'
  get 'users/unsubscribe' => 'users#unsubscribe'
  patch 'users/withdraw' => 'users#withdraw'
  resources "users", path: 'users/my_page', only: [:show, :edit, :update]
  resources "users" do
    member do
      get :matching
      get :following, :followers
    end
  end
  resources :relationships, only: [:create]


  mount ActionCable.server => '/cable'
  root to: "homes#top"
  get "about" => "homes#about", as: "about"

end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
