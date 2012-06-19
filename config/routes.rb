Locomotive::Engine.routes.draw do

  # authentication
  devise_for :locomotive_account,
    :class_name   => 'Locomotive::Account',
    :path         => '',
    :path_prefix  => nil,
    :failure_app  => 'Locomotive::Devise::FailureApp',
    :controllers  => { :sessions => 'locomotive/sessions', :passwords => 'locomotive/passwords' }

  devise_scope :locomotive_account do
      match '/'         => 'sessions#new'
      delete 'signout'  => 'sessions#destroy', :as => :destroy_locomotive_session
  end

  root :to => 'pages#index'

  resources :pages do
    put :sort, :on => :member
    get :get_path, :on => :collection
  end

  resources :snippets

  resources :sites

  resource :current_site, :controller => 'current_site'

  resources :accounts

  resource :my_account, :controller => 'my_account'

  resources :memberships

  resources :theme_assets do
    get :all, :action => 'index', :on => :collection, :defaults => { :all => true }
  end

  resources :content_assets

  resources :content_types

  resources :content_entries, :path => 'content_types/:slug/entries' do
    put :sort, :on => :collection
  end

  # installation guide
  match '/installation'       => 'installation#show', :defaults => { :step => 1 }, :as => :installation
  match '/installation/:step' => 'installation#show', :as => :installation_step
end

