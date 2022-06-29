Rails.application.routes.draw do
  # エンドユーザー用
  # URL /users/sign_in ...
  # passwordsコントローラーを生成しない
  devise_for :users, skip: [:passwords], controllers: {
    omniauth_callbacks: 'public/omniauth_callbacks',
    registrations: "public/registrations",
    sessions: 'public/sessions',
  }

# devise_scope→新しくdeviseにルーティングを追加する時に使用
# ゲストログイン
  devise_scope :user do
    post 'public/users/guest_sign_in', to: 'public/users/sessions#guest_sign_in'
  end

  # エンドユーザー側ルーティング
  scope module: :public do
    resources :chat_rooms, only: [:create, :show]
    resources :notifications, only: [:index]

    get '/activity_points' => 'activity_points#search'
    get '/activity_points/spot' => 'activity_points#search_spot'
    resources :activity_points, only: [:new, :create, :edit, :update, :destroy]
    get '/activity_points/user_record' => 'activity_points#user_record'

    get 'users/matchings' => 'users#matchings'
    get 'users/unsubscribe' => 'users#unsubscribe'
    patch 'users/withdraw' => 'users#withdraw'
    resources "users", path: 'users/my_page', only: [:show, :edit, :update]
    # menberはユーザーidが含まれているURLを扱える
    resources "users" do
      member do
        get :matching
        get :following, :followers
      end
    end
    resource :relationships, only: [:create]

    # ActionCable::Server::Baseのインスタンスを返す
    mount ActionCable.server => '/cable'
    root to: "homes#top"
    get "about" => "homes#about", as: "about"
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
