Rails.application.routes.draw do

  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions'
  }
  devise_scope :user do
    get "sign_in", :to => "users/sessions#new"
    get "sign_out", :to => "users/sessions#destroy"
  end

  def devise_scope(scope)
    constraint = lambda do |request|
      request.env["devise.mapping"] = Devise.mappings[scope]
      true
    end
    constraints(constraint) do
      yield
    end
  end


  root :to => 'users#top'
  get 'users/about'
  get "users/hide" => "users#hide", as: 'users_hide'
  patch "users/withdrawal" => "users#withdrawal", as: 'users_withdrawal'
  get "search" => "search#search"

  resources :users, only: [:show,:index,:edit,:update] do
    get 'relationships/index'
    get 'relationships/following/:user_id' => 'users#following'
    get 'relationships/follower/:user_id' => 'users#follower'
  end
  resources :relationships, only: [:create,:destroy]
  resources :messages, only: [:create,:destroy]
  resources :rooms, only: [:create, :show, :index]

end
