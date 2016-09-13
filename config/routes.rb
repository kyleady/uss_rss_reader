Rails.application.routes.draw do
  resources :feeds do
    resources :articles
  end

  get 'welcome/index'

  root 'welcome#index'
end
