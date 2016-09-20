Rails.application.routes.draw do
  resources :feeds do
    resources :articles do
      member do
        get 'toggle_viewed'
      end
    end
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
