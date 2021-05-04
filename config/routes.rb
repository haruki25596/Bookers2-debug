Rails.application.routes.draw do

  devise_for :users
  root to: 'homes#top'
  get 'home/about'=> 'homes#about'

  post 'follow/:id' => 'relationships#follow', as: 'follow' # フォローする
  post 'unfollow/:id' => 'relationships#unfollow', as: 'unfollow' # フォロー外す
  get 'users/:id/follower'=> 'users#follower', as: 'follower_user'
  get 'users/:id/followed'=> 'users#followed', as: 'followed_user'

  resources :users,only: [:show,:index,:edit,:update]

  resources :books, only: [:new, :create, :index, :show, :destroy] do
    resources :book_comments, only: [:create, :destroy]
  end
  resources :books,only: [:index, :show, :create, :edit, :update, :destroy] do
    resource :favorites, only: [:create, :destroy]
 end

end