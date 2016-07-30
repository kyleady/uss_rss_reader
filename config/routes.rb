Rails.application.routes.draw do
  #positions users to add new feeds but does not edit anything yet
  #get 'feeds/new'
  #parsing the feed will also save the url, thus it is a post
  #post 'feeds/parse_rss'
  resources :feeds

  #title page
  get 'welcome/index'

  #default page
  root 'welcome#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
