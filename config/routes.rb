# frozen_string_literal: true
Rails.application.routes.draw do
  resources :line_items, :carts, :orders
  resources :products do
    get :who_bought, on: :member
  end

  root 'store#index', as: 'store_index'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
