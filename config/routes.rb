Rails.application.routes.draw do
     
     devise_scope :user do
       get 'user/profile/:id', to: 'registrations#profile', as: 'profile'
       patch 'user/change_pass' , to: 'registrations#change_password' , as: 'change_pass'
       patch 'user/add_avatar' , to: 'registrations#add_avatar' , as: 'add_avatar'
    end
  devise_for :users ,:controllers => {:registrations =>
"registrations" , :sessions => "sessions"}
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
authenticated :user do
  root :to => 'homes#index', :as => :authenticated_root
end
root :to => redirect('/users/sign_in')



#TEST

  # Example of regular route:
     # get 'user/:id' => 'registrations#show' , :as =>  :user

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  
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
