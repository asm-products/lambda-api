Rails.application.routes.draw do
  devise_for :users, skip: :session, path: '',
                     controllers: { omniauth_callbacks: 'omniauth_callbacks' }
end
