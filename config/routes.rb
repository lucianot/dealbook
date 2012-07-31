Dealbook::Application.routes.draw do

  match '/auth/:provider/callback' => 'authentications#create'
  
  resources :authentications

  devise_for :users, :controllers => {:registrations => 'registrations'}
  resources :users, :only => [:show, :index, :edit, :update]
  resources :deals do
      put :verify, :on => :member
      put :unverify, :on => :member
  end
  resources :companies
  resources :investors
  resources :markets, :except => :show
  resources :locations, :except => :show
  resources :searches, :only => [:show, :create]
  resources :home, :only => :index

  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
end
