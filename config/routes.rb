Rails.application.routes.draw do
  get '/index', to: 'app/front#index', as: :app_index
  root to: 'app/front#index'

  devise_for :users, skip: KepplerConfiguration.skip_module_devise

  namespace :admin do
    resources :stack_states, except: [:destroy] do
      get '(page/:page)', action: :index, on: :collection, as: ''
      get '/clone', action: 'clone'
      delete(
        action: :destroy_multiple,
        on: :collection,
        as: :destroy_multiple
      )
    end

    resources :orders, except: [:destroy] do
      get '(page/:page)', action: :index, on: :collection, as: ''
      # get '/clone', action: 'clone'
      get '/history', action: 'history'
      get '/edition', action: 'edition'
      get '/search_order', action: :search_order, on: :collection, as: 'search_order'
      post '/create_report', action: :create_report, on: :collection, as: 'create_report'
      delete(
        action: :destroy_multiple,
        on: :collection,
        as: :destroy_multiple
      )
    end

    # resources :orders do

    #   get '(page/:page)', action: :index, on: :collection, as: ''
    #   get '/clone', action: 'clone'
    #   # get '/view_data', action: 'view_data'
    #   # get '/report', action: :report, on: :collection, as: 'report'
    #   # post '/create_report', action: :create_report, on: :collection, as: 'create_report'
    #   delete(
    #     action: :destroy_multiple,
    #     on: :collection,
    #     as: :destroy_multiple
    #   )
    # end

    resources :tasks, except: [:destroy] do
      get '(page/:page)', action: :index, on: :collection, as: ''
      get '/clone', action: 'clone'
      delete(
        action: :destroy_multiple,
        on: :collection,
        as: :destroy_multiple
      )
    end

    resources :phases, except: [:destroy] do
      get '(page/:page)', action: :index, on: :collection, as: ''
      get '/clone', action: 'clone'
      delete(
        action: :destroy_multiple,
        on: :collection,
        as: :destroy_multiple
      )
    end

    resources :projects, except: [:destroy] do
      get '(page/:page)', action: :index, on: :collection, as: ''
      get '/clone', action: 'clone'
      delete(
        action: :destroy_multiple,
        on: :collection,
        as: :destroy_multiple
      )
    end

    resources :customizes do
      get '(page/:page)', action: :index, on: :collection, as: ''
      get '/clone', action: 'clone'
      post '/install_default', action: 'install_default'
      delete(
        action: :destroy_multiple,
        on: :collection,
        as: :destroy_multiple
      )
    end

    root to: 'admin#root'

    resources :users, except: [:destroy] do
      get '(page/:page)', action: :index, on: :collection, as: ''
      delete(
        '/destroy_multiple',
        action: :destroy_multiple,
        on: :collection,
        as: :destroy_multiple
      )
    end

    resources :meta_tags do
      get '(page/:page)', action: :index, on: :collection, as: ''
      delete(
        '/destroy_multiple',
        action: :destroy_multiple,
        on: :collection,
        as: :destroy_multiple
      )
    end

    resources :google_adwords do
      get '(page/:page)', action: :index, on: :collection, as: ''
      delete(
        '/destroy_multiple',
        action: :destroy_multiple,
        on: :collection,
        as: :destroy_multiple
      )
    end

    resources :google_analytics_tracks do
      get '(page/:page)', action: :index, on: :collection, as: ''
      delete(
        '/destroy_multiple',
        action: :destroy_multiple,
        on: :collection,
        as: :destroy_multiple
      )
    end

    resources :settings, only: [] do
      collection do
        get '/:config', to: 'settings#edit', as: ''
        put '/:config', to: 'settings#update', as: 'update'
        put '/:config/appearance_default', to: 'settings#appearance_default', as: 'appearance_default'
      end
    end
  end


  #Peticiones AJAX 
  resources :projects
  post 'admin/projects/search', as: 'projects_search'

  resources :phases
  post 'admin/tasks/options', as: 'phases_options'

  resources :orders
  post 'admin/orders/project', as: 'orders_project'
  post 'admin/orders/payment_currency', as: 'orders_payment_currency'

  get "users/pending",to:"app/users#pending", as: :app_users_pending
  get "users/locked",to:"app/users#locked", as: :app_users_locked


  # resources :tasks
  # post 'admin/tasks/dinamic', as: 'tasks_dinamic'
  

  # Errors routes
  match '/403', to: 'errors#not_authorized', via: :all, as: :not_authorized
  match '/404', to: 'errors#not_found', via: :all
  match '/422', to: 'errors#unprocessable', via: :all
  match '/500', to: 'errors#internal_server_error', via: :all

  # Dashboard route engine
  mount KepplerGaDashboard::Engine, at: 'admin/dashboard', as: 'dashboard'
end
