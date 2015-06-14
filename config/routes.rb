Rails.application.routes.draw do
  devise_for :users, skip: :session, path: '',
                     controllers: { omniauth_callbacks: 'omniauth_callbacks' }

  resources :categories, only: %i(index)
end
