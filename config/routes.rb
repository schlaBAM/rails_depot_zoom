# frozen_string_literal: true
Rails.application.routes.draw do
  get 'admin' => 'admin#index'

  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end

  resources :users
  resources :products do
    get :who_bought, on: :member
  end

  scope '(:locale)' do
    resources :orders, :line_items, :carts
    root 'store#index', as: 'store_index'
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
