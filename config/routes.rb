Rails.application.routes.draw do
  get 'robot_chat/chat_with_robot2'

  get 'robot_chat/get_evaluation2'
  get 'robot_chat/test_eva2'
  post 'robot_chat/test_eva2'
  
  resources :tests
  resources :friendships
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


  resources :users do
    collection do
      get :index_json
    end
  end


  # post "users/add_new_user"

  resources :salaries
  resources :performances
  resources :announcements
  resources :materials
  resources :articles
  resources :departments
  resources :companynews
  resources :vacation

  resources :messages do
    collection do
      delete :destroyall
    end
  end

  resources :chats do
    member do
      patch :trans_auth
      post :add_user
      delete :delete_user
    end
  end

  resources :friendships

  root 'homes#home'

  get 'sessions/login' => 'sessions#new'
  post 'sessions/login' => 'sessions#create'
  delete 'sessions/logout' => 'sessions#destroy'
  get 'sessions/signup' => 'sessions#new'
  post 'sessions/signup' => 'sessions#sign_up'
 
  # 这里添加一个新的请求，解决机器人聊天的问题
  # match 'robot/chat_with_robot', to: 'robot#chat_with_robot', via: [:get]
  get 'robot/chat_with_robot'
  post 'robot/store_evaluation'
  get 'robot/get_evaluation'

  # 添加用户的请求
  post 'extend_users/add_new_user'
  # 获取一个用户的信息
  get 'extend_users/get_user_information'
  # 修改用户信息
  post 'extend_users/modify_user_information'
end
