Rails.application.routes.draw do
  devise_scope :user do
    get 'user/profile/:id', to: 'registrations#profile', as: 'profile'
    patch 'user/change_pass', to: 'registrations#change_password', as: 'change_pass'
    patch 'user/add_avatar', to: 'registrations#add_avatar', as: 'add_avatar'
  end
  devise_for :users, :controllers => {:registrations => "registrations", :sessions => "sessions"}
# api routes
  namespace :api, defaults: {format: 'json'} do
    devise_scope :user do
      post 'change_password', to: 'registrations#change_password', as: 'change_password'
      post 'edit_profile', to: 'registrations#edit_profile', as: 'edit_profile'
      post 'log_out', to: 'sessions#sign_out', as: 'log_out'
      get 'profile', to: 'registrations#profile', as: 'profile'
      # devise_for :users
      post 'sign_up' , to: 'registrations#create'
      post 'log_in', to: 'sessions#sign_in'

    end
    get 'condos', to: 'condos#list', as: 'listcondo'
    get 'condos_detail', to: 'condos#show', as: 'showcondo'
    post 'send_feedback', to: 'feedbacks#create'
    get 'list_subject', to: 'feedbacks#list_cat'
    get 'get_facilities', to: 'bookings#get_facilities'
    get 'count_facility', to: 'bookings#count_facility'
    get 'my_bookings', to: 'bookings#my_bookings'
    get 'get_facility_categories', to: 'bookings#get_facility_categories'
    get 'get_users', to: 'users#get_users'

  end


#resources :event_images
  get 'active' , to: 'homes#unauthor' , as: 'active'
  resources :admins , :only => [:index , :new]
  get 'admins/roles' , to: 'roles#index' , as: 'roles'
  get 'admins/confirm_drop/:id' , to: 'roles#confirm_drop' , as: 'confirm_drop'
  delete 'admins/drop_role/:id',to: 'roles#drop_role' , as: 'drop_role'
  get 'admins/roles/show' , to: 'roles#show'
  get 'admins/roles/rename' , to: 'roles#rename_role'
  get 'admins/roles/new' , to: 'roles#new' , as: 'new_roles'
  post 'admins/roles/new' , to: 'roles#create' , as: 'create_roles'
  post 'admins/remove_multiple' , to: 'roles#remove_multiple' , as: 'remove_multiple'
  get 'admins/roles/add/:id' , to: 'roles#add_permission' , as: 'add_permission'
  put 'admins/process' , to: 'roles#process_add_permission' , as: 'process_role'
  get 'roles/cofirm/:rid/:pid', to: 'roles#confirm_remove' , as: 'confirm_remove'
  delete 'roles/remove_permsion/:id' ,to: 'roles#remove_permission' , as: "remove_permission"
  get 'admin/manage_user/:id' ,to: 'admins#manage' , as: "manage_user"
  get'admin/delete_confirm/:id' ,to: 'admins#confirm' , as: "confirm_delete"
  delete'admin/delete_user/:id' ,to: 'admins#destroy' , as: "delete_user"
  post 'admin/add_role' , to: 'admins#process_add_role' , as: "processs_add_role"
  delete 'admin/remove_role/:uid/:rid' , to: 'admins#remove_role' , as: "remove_role"
  post  'admin/change_active'  , to: 'admins#change_active'
  post  'admin/create_user' , to: "admins#create_user" , as: "create_user"
  get  'admin/edit_user/:id' , to: "admins#edit_user" , as: "edit_user"
  patch  'admin/update_user/:id' , to: "admins#update_user" , as: "update_user"
  post 'admins/destroy_multiple' , to: "admins#destroy_multiple"
  resources :condos
  post 'condos/images', to: 'condos#create_image', as: 'create_image'
  resources :services
  get 'services/confirms/:id', to: "services#confirm", as: 'confirm_service'
  resources :feedbacks, :only => [:index, :destroy]
  get 'feedbacks/moves', to: "feedbacks#move_archive", as: 'archive'
  get 'feedbacks/destroymultiple', to: "feedbacks#destroy_multiple", as: 'destroy_feedbacks'
  get 'feedbacks/confirms/:id', to: "feedbacks#confirm_delete", as: 'confirm_feedback'
  get 'feedbacks/reply/:id', to: "feedbacks#create_reply", as: 'create_reply'
  post 'feedbacks/reply', to: "feedbacks#reply", as: 'reply'
  put 'feedbacks/reply', to: "feedbacks#update_reply", as: 'update_reply'
  post 'feedbacks/destroy_multiple', to: "feedbacks#destroy_multiple"
  post 'feedbacks/move_multiple', to: "feedbacks#move_multiple"
  get 'feedbacks/archive', to: "feedbacks#index_archive", as: "feedbacks_archive"
  resources :events do
    collection do
      get 'archives'
    end
    member do
      get 'archive'
      get 'unarchive'
    end
  end

  resources :facilities do
    get 'timeslot'
    member do
      get 'confirm'
    end

  end
  post 'facilities/change_active', to: 'facilities#change_active'
  post 'facilities/change_peak', to: 'facilities#change_peak'
  post 'facilities/add_timeslot', to: 'facilities#add_timeslot', as: 'add_timeslot'
  post 'facilities/delete_timeslot/:id', to: 'facilities#delete_timeslot', as: 'delete_timeslot'

  resources :facility_statuses, only: [:new, :create]

  resource :facility_status, only: [] do
    member do
      get 'previous'
      get 'next'
    end
  end

  get 'bookings/filter/:id' => 'bookings#filter', as: 'filter'
  resources :bookings, only: [:index, :update, :destroy] do

    collection do
      post 'deleteColection'
      post 'updateStatus'
      get 'confirm'
      get 'getLanguage'
    end
  end

  resources :bulletins do
    member do
      get 'confirm'
    end
  end

  resources :forms do
    collection do
      post 'filter'
    end
    member do
      get 'confirm'
    end
  end

  resources :guard_houses, only: [:index, :update] do
    collection do
      post 'update_photo'
      post 'delete_photo'
    end
  end

  resource :guard_house, only: [:edit] do
  end

  resources :house_rules do
    member do
      get 'confirm'
    end
  end

  resources :guard_house_images

  resources :privileges

  resources :privilege_users, only: []

  resources :services, only: []

  resources :service_categories, only: []

  resources :courses

  resources :about_us

  resources :tech_supports

  resources :course_users, only: []

# The priority is based upon order of creation: first created -> highest priority.
# See how all your routes lay out with "rake routes".

# You can have the root of your site routed with "root"
  authenticated :user do
    root :to => 'homes#index', :as => :authenticated_root
  end
  root :to => redirect('/users/sign_in')

# Example of regular route:
#   get 'products/:id' => 'catalog#view'

# Example of named route that can be invoked with purchase_url(id: product.id)
#   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

# Example resource route (maps HTTP verbs to controller actions automatically):
  resources :homes, only: [:index,:setLanguage] do
    collection do
      post 'setLanguage' => 'homes#setLanguage'
    end
  end

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

  namespace :api, path: nil do
    resource :event, only: [], path: 'api' do
      collection do
        get 'events' => 'events#index'
        get 'event_archives' => 'events#event_archives'
      end
      member do
        get 'list_user' => 'events#list_user'
        get 'event_detail' => 'events#show'
        get 'event_detail_photo' => 'events#event_photo'
        post 'join_event' => 'events#join_event'
      end
    end
  end

  namespace :api, path: nil, defaults: {format: :json} do
    resource :bulletin, only: [], path: 'api' do
      collection do
        get 'bulletins' => 'bulletins#index'
      end
      member do
        get 'bulletin_detail' => 'bulletins#show'
      end
    end



    resource :form, only: [], path: 'api' do
      collection do
        get 'forms' => 'forms#index'
        get 'get_forms' => 'forms#get_forms'
        get 'count_forms' => 'forms#count_forms'
      end
    end

    resource :house_rule, only: [], path: 'api' do
      collection do
        get 'house_rules' => 'house_rules#index'
      end
    end

    resource :privileges, only: [], path: 'api' do
      collection do
        get 'privileges' => 'privileges#index'
        get 'privilege_detail' => 'privileges#privilege_detail'
        get 'my_privileges'
        post 'delete_my_privilege'
        post 'redeem_previlege' => 'privileges#redeem_previlege'
      end
    end

    resource :about_us, only: [], path: 'api' do
      member do
        get 'about_us'
      end
    end

    resource :tech_support, only: [], path: 'api' do
      member do
        get 'tech_support'
      end
    end

    resource :contact_us, only: [], path: 'api' do
      collection do
        post 'send_contact_us' => 'contact_us#create'
      end
    end

    resource :service_category, only: [], path: 'api' do
      collection do
        get 'service_categories' => 'service_categories#index'
      end
    end

    resource :service, only: [], path: 'api' do
      collection do
        get 'services' => 'services#index'
      end
      member do
        get 'service_detail' => 'services#show'
      end
    end

    resource :course, only: [], path: 'api' do
      collection do
        get 'courses' => 'courses#index'
      end
      member do
        get 'course_detail' => 'courses#show'
      end
    end

    resource :course_user, only: [], path: 'api' do
      member do
        post 'join_course' => 'course_users#create'
        get 'cancel' => 'course_users#destroy'
        get 'has_join' => 'course_users#show'
      end
    end

    resources :merchants, only: [], path: 'api' do
      collection do
        post 'request_merchant' => 'merchants#create'
      end
    end

    resource :chats, only: [], path: 'api' do
      collection do
        post 'request_friend' => 'chats#request_friend'
        post 'confirm_friend_request' => 'chats#confirm_friend_request'
        get 'friend_list' => 'chats#friend_list'
        get 'pending_request' => 'chats#pending_request'
        get 'neightbours' => 'chats#neightbours'
        post 'send_chat_message' => 'chats#send_chat_message'
        post 'create_group_chat' => 'chats#create_group_chat'
        post 'send_chat_group' => 'chats#send_chat_group'
        get 'history_chat_group_list' => 'chats#history_chat_group_list'
        get 'history_chat_individual_list' => 'chats#history_chat_individual_list'
      end
    end

  end

  namespace :api, path: nil do
    resources :booking, only: [], path: 'api' do
      collection do
        get 'booking_facilities' => 'bookings#index'
        post 'make_a_booking' => 'bookings#make_a_booking'
        get 'check_booking' => 'bookings#check_booking'
        get 'booking_detail' => 'bookings#booking_detail'
        post 'delete_my_booking' => 'bookings#delete_my_booking'
      end
    end
  end

  namespace :api, path: nil do
    resources :guard_houses, only: [], path: 'api' do
      collection do
        get 'guard_houses'
      end
    end
  end




  get "*path", :to => "application#routing_error"
end

