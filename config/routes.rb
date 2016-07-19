Rails.application.routes.draw do
  get 'feeds/new'

  get 'feeds/parse_rss'

  get 'welcome/index'

  root 'welcome#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
