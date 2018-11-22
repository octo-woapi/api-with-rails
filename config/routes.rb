# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'home#index'

  namespace :api do
    namespace :v1, defaults: { format: :json } do
      resources :products, only: %i[index show create update destroy]
      resources :orders, only: %i[index show create update destroy]

      match '*path', to: 'api#not_found', via: :all
    end
  end

  match '*path', to: 'application#not_found', via: :all

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
