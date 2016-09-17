Rails.application.routes.draw do
  resources :feeds do
    resources :articles
  end

  resource :user do
    collection do
      get 'logout'
      get 'sign_in'
      post 'begin_session'
    end
  end

  get 'welcome/index'

  root 'welcome#index'
end
