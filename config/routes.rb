Rails.application.routes.draw do
  resources :home, only: [:index]
  get 'home/insides', to: 'home#insides', as: :home_insides
  get 'home/no_access', to: 'home#no_access', as: :no_access
  get 'contact-us', to: 'home#contactus', as: 'contact-us'
  get 'faq', to: 'home#faq', as: :faq
  get 'about', to: 'home#about', as: :about

  #social redirects
  get '/facebook', to: redirect('http://www.facebook.com')
  get '/pinterest', to: redirect('http://www.pinterest.com')
  get '/instagram', to: redirect('http://www.instagram.com')
  get '/youtube', to: redirect('http://www.youtube.com')
  get '/twitter', to: redirect('http://www.twitter.com')


  resources :events
  resources :project_restrictions
  resources :project_dates
  root 'home#index'


  #Omniauth
  

  devise_for :users, path: '', :controllers => { :registrations => 'users/registrations',   
    :confirmations => 'users/confirmations', :sessions => 'users/sessions', 
    :passwords => 'users/passwords', omniauth_callbacks: "users/omniauth_callbacks"}


  devise_scope :user do
    get 'sign_in', to: 'users/sessions#new'

    patch "confirm" => "users/confirmations#confirm"
    delete "sign_out" => "users/sessions#destroy"
    post "sign_in" => "users/sessions#create"
    get  "users/auth/google_login/callback" ,:to => "users/omniauth_callbacks#goole_oauth2"

    get "sign_up", to: 'users/registrations#new'
    get 'users/registrations/signup_success', to: 'users/registrations#signup_success', as: :signup_success
    delete '/auth/sign_out', :to => 'users/sessions#destroy'
    get 'users/auth/:provider/callback', to: 'users/sessions#create'
    get 'failure', to: redirect('/')
    get 'signout', to: 'users/sessions#destroy', as: 'signout'
    get 'users/:id/finish_signup' => 'users#finish_signup', via: [:get, :patch], :as => :finish_signup
    get 'users/auth/google_oauth2', to:  'users/omniauth_callbacks#passthru'
    get 'passwords/check_email_for_password', to:  'users/passwords#check_email_for_password', as: :check_email_for_password


  end



  namespace :inside do
     resources :dashboard, only: [:index]
     # resources :no_access_logs, only: [:index, :show]
     resources :blog_posts
     resources :blog_post_originals, :controller => 'blog_posts'
     resources :blog_post_versions, :controller => 'blog_posts'

     resources :blog_authors, only: []
     resources :blog_references, only: []
     resources :social_accounts
     resources :social_shares

  end
  # get '/page/:page_id' => 'site#page', as: :site_page

  resources :projects, except: [:new, :show]

  resources :new_baby_meal_delivery_projects, :controller => 'projects', except: [:new]
  get 'projects/kinds', to: 'projects#kinds', as: :project_kinds

  get 'projects/new/:id', to: 'projects#new', as: :new_project

  get 'projects/roles/:project_type_code', to: 'projects#roles', as: :role_project
  get 'add_project', to: 'projects#create', as: :add_project
  patch 'update_date_range/:id', to: 'projects#update_date_range', as: :update_date_range


  resources :contacts, except: [:show]
  get 'contacts/import_results', to: 'contacts#import_results', as: :import_results

  resources :households, only: []
  patch 'split_households', to: 'households#split_households', as: :split_households
  patch 'join_households', to: 'households#join_households', as: :join_households


  resources :projects , except: [:new] do 
    get 'recipients', to: 'projects#recipients', as: :add_recipients

    resources :dashboard, only: [:index]
    resources :invites, only: [:show]
    get 'resend_invite/:id', to: 'invites#resend_invite', as: :resend_invite




    # resources :card_lists, :controller => 'lists', except: [:new]
    # resources :baby_announcement_card_lists, :controller => 'lists', except: [:new]

    resources :participants
    resources :project_dates, only: [:show]
    patch 'add_event/:project_date_id', to: 'project_dates#add_event', as: :add_event
    get 'approval_response/:id/:approval', to: 'events#approval_response', as: :event_response
      resources :project_dates , except: [:new] do 
        # resources :events, except: [:create]
        # post 'events/add_event', to: 'events#add_event', as: :add_event
        
      end
 


    post 'invite_participants', to: 'participants#invite_participants', as: :invite_participants
    patch 'invite_recipients/:id', to: 'projects#invite_recipients', as: :invite_recipients

    get 'restrictions', to: 'projects#restrictions', as: :add_restrictions
    patch 'update_restrictions', to: 'projects#update_restrictions', as: :update_restrictions
    get 'available_dates', to: 'projects#available_dates', as: :available_dates
    patch 'update_available_dates', to: 'projects#update_available_dates', as: :update_available_dates
    get 'edit_date_range', to: 'projects#edit_date_range', as: :edit_date_range
    patch 'update_date_range', to: 'projects#update_date_range', as: :update_date_range

  end
  resources :events, only: [:create]
 
      # post 'events/add_event/:project_date_id/:project_id', to: 'events#add_event', as: :add_event
      post 'add_event/:project_date_id/:project_id', to: 'events#add_event', as: :add_event

  resources :invites, only: [:index,  :update]

  get 'rsvp/:id/:rsvp', to: 'invites#rsvp', as: :rsvp


   resources :lists, except: [:show]
    resources :guest_lists, controller: 'lists', except: [:new]
    resources :card_lists, controller: 'lists', except: [:new]
    resources :lists, except: [:show] do
      collection { post :import }
    end

  get 'lists/list_types', to: 'lists#list_types', as: :list_types
  get 'lists/list_project', to: 'lists#list_project', as: :list_project

  resources :feedbacks, only: [:new, :create]
  get 'lists/:id', to: 'lists#show', as: :mailing_list

  


  namespace :blog , path: "" do
     root  'articles#index'
     resources :articles, only: [:index, :show]
     resources :sections, only: [:index, :show]
     resources :contributors, only: [:index, :show]

  end



  # constraints({ subdomain: "blog" }) do
  #   namespace :blog , path: "" do
  #    root  'articles#index'
  #    resources :articles, only: [:index, :show]
  #    resources :sections, only: [:index, :show]
  #    resources :contributors, only: [:index, :show]

  #   end

  # end

end
