# frozen_string_literal: true
Rails.application.routes.draw do
  get 'admin' => 'admin#index'

  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end

  get 'sessions/create'
  get 'sessions/destroy'

  resources :line_items, :carts, :orders, :users

  resources :products do
    get :who_bought, on: :member
  end

  root 'store#index', as: 'store_index'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
