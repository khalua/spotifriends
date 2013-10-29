Spotifriends::Application.routes.draw do
  devise_for :users, :controllers => { :passwords => "passwords" }

  root :to => 'welcome#index'
  resources :users, :only => [:edit, :new, :create, :show, :update]
  resources :contests do
    collection do
      get 'add_group'
      post 'create_group'
    end
    get 'results'
      resources :songs do
      end
  end

  resources :requests, :only => [:edit, :new, :create]
  get '/requests/thanks' => 'requests#thanks'

  get 'users/claim_account/:id' => 'users#claim_account', :as => :claim_account

  post '/contests/:contest_id/songs/:id/vote' => 'votes#vote'

  get '/search/:spy_id' => 'songs#get_song_info'

  # get '/login'  => 'session#new'
  # post '/login' => 'session#create'
  # delete '/login' => 'session#destroy'
end
