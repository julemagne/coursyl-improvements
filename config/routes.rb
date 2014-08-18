Courses::Application.routes.draw do
  get "home/index"
  get "home/requests"
  get "slides/show"

  devise_for :users

  resources :courses do
    member do
      get 'policies'
      post 'policies'
      get 'grade_thresholds'
      post 'grade_thresholds'
      post 'enroll'
      post 'register'
    end
    collection do
      get 'new_options'
      get 'copy'
      post 'copy'
    end
  end
  resources :course_students do
    member do
      patch 'approve'
      get 'change_email'
      patch 'change_email'
      get 'change_password'
      patch 'change_password'
      get 'change_code'
      patch 'change_code'
    end
  end
  resources :schools
  resources :terms
  resources :users do
    member do
      post 'approve_as_instructor'
      post 'reject_as_instructor'
      get 'new_student'
      post 'create_student'
    end
  end
  resources :assignments do
    member do
      post 'turn_in'
      get 'grade'
      post 'grade'
      get 'grade_matrix'
      post 'grade_matrix'
      get 'view_grades'
    end
  end
  resources :achievements do
    collection do
      get 'award'
      post 'award'
    end
  end
  resources :lessons do
    collection do
      get 'schedule'
    end
  end
  resources :meetings do
    member do
      get 'lead_in_question'
      get 'outline'
      get 'media'
    end
    collection do
      post 'create_many'
    end
  end
  resources :meeting_lessons do
    member do
      delete 'destroy_and_shift'
    end
  end

  # You can have the root of your site routed with "root"
  root 'home#index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

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
