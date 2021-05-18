# frozen_string_literal: true

Rails.application.routes.draw do
  get 'proposal/create'
  get 'order/create'
  get 'order_creation/create'
  get 'users/new'
  get 'users/update'

  mount_devise_token_auth_for 'User', at: 'api/v1/auth'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      resources :catalogues, only: %i[create index show update]
      namespace :tailors do
        resources :orders, only: %i[index]
        resources :reviews, only: %i[update], shallow: true
        get '/:id/reviews', to: 'reviews#index'
        resources :proposal_biddings, only: %i[index show accept reject] do
          member do
            put :accept
            post :reject
          end
        end
      end

      resources :users, only: %i[update show] do
        collection do
          get :accepted_biddings
          resources :proposal_biddings, only: [:index]
        end
      end
      resources :skills, only: [:index, :show]do
        collection do
          get :popular_skills
        end
      end
      resources :categories, only: :index
      resources :tailors, only: %i[index update show] do
        collection do
          get :top_rated_tailors
        end
        member do
          resources :favorite_tailors, only: %i[create destroy], shallow: true
        end
      end
      resources :proposals, only: %i[create index update customer_declined_bidding show] do
        member do
          put :convert_to_order
          post :customer_declined_bidding
          put :add_inspiration_images
        end
      end
      resources :reviews, only: %i[create update]
      resources :portfolios, only: %i[show destroy]
      resources :tailor_skills, only: %i[show destroy]
      resources :orders, only: %i[show index] do
        member do
          resources :order_items, param: :order_item_id, only: [] do
            member do
              put :toggle_size_profile
            end
          end
        end
      end
      resources :standard_fields, only: %i[index]
      resources :size_profiles, only: %i[index show create update destroy]
      resources :order_items, only: [], param: :order_item_id do
        member do
          resources :order_item_size_profiles, only: %i[show create update destroy]
        end
      end
    end
  end
end
