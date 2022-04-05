Rails.application.routes.draw do
# エンドユーザー用
# URL /users/sign_in ...
devise_for :users,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

#顧客側ルーティング
scope module: :public do


root to: "homes#top"
get "about" => "homes#about", as: "about"
end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
