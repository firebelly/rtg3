Rails.application.routes.draw do
  #legacy URLs
  get '/news-and-events', to: redirect('/news')
  get '/news-and-events/:id', to: redirect('/news/%{id}')
  get '/apply-spanish', to: redirect('/apply')
  get '/about', to: redirect('/about-us')
  get '/whats-the-point', to: redirect('/about-us')
  get '/how-does-this-work', to: redirect('/about-us')
  get '/testimonials', to: redirect('/about-us')
  get '/humboldt-park', to: redirect('/about-us')
  get '/history', to: redirect('/about-us')
  get '/culture', to: redirect('/about-us')
  get '/responsible-buying', to: redirect('/about-us')
  get '/for-sponsors', to: redirect('/get-involved')
  get '/press', to: redirect('/news')
  get '/reasons/search', to: redirect('/give')
  get '/success_stories', to: redirect('/success-stories')
  get '/success_stories/:id', to: redirect('/success-stories/%{id}')

  devise_for :users
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  root :to => "pages#home", id: 'home'

  resources :reasons, :only => [ :index, :show ]

  resource :cart, only: [:show] do
    post 'add', to: 'carts#add', as: :add_to
    put 'update/:donation_item_id', to: 'carts#update', as: :update
    get 'remove/:donation_item_id', to: 'carts#remove', as: :remove_from
    get 'ajax_cart', to: 'carts#ajax_cart'
    get 'ajax_token', to: 'carts#ajax_token'
    get 'count', to: 'carts#count', as: :count
    get 'total', to: 'carts#total', as: :total
  end

  resources :applicants, :only => [ :create, :show ]
  post '/applicants/contact', to: 'applicants#contact', as: :applicants_contact

  resources :donations, :only => [ :create ]
  resources :payment_records, only: [ :create ]

  # custom pages
  get '/what-we-do' => 'pages#what_we_do', id: 'what-we-do'
  get '/get-involved' => 'pages#get_involved', id: 'get-involved'
  get '/apply' => 'pages#apply', id: 'apply'
  get '/about-us' => 'pages#about_us', id: 'about-us'
  get '/supporters' => 'pages#supporters', id: 'supporters'
  
  # get '/press' => 'posts#press_index', :id => 'press'
  # get '/press/:id' => 'posts#press_show', as: 'press_post'

  get '/give' => 'reasons#index'
  get '/thanks/:donation_id' => 'reasons#thanks', as: 'thanks'

  get '/success-stories' => 'reasons#success_stories'
  get '/success-stories/:id' => 'reasons#success_story', :as =>'success_story'

  resources :posts, :only => [ :show ]
  get '/news' => 'posts#index', as: 'news'
  # get '/news/:id' => 'posts#news_show', as:'news_post'

  # fall-through to pages
  get '/:id(/:child_id)' => 'pages#show', as: 'page'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
