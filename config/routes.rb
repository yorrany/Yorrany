Rails.application.routes.draw do
  get "home/index"
  get "/privacy", to: "home#privacy"
  get "/llms.txt", to: "home#llms"
  get "/cv/:filename", to: "cv#show"
  get "/vcard", to: "contact#vcard"

  resources :blog, controller: "blog", only: [ :index, :show ]
  get "/auth/:provider/callback", to: "linkedin_auth#callback"
  get "/auth/failure", to: "linkedin_auth#failure"

  devise_for :users, controllers: { sessions: "users/sessions" }

  get "/admin", to: "admin/dashboard#index"
  namespace :admin do
    resources :case_studies, except: [ :show ] do
      member do
        delete "attachments/:attachment_id", action: :purge_attachment, as: :purge_attachment
      end
    end
    resources :experience_items, except: [ :show ]
    resources :certifications, except: [ :show ] do
      patch :reorder, on: :collection
    end
    resources :academic_backgrounds, except: [ :show ]
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "home#index"
end
