Dealbook::Application.routes.draw do
  devise_for :users
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
