Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  namespace :admin do
    resources :topics
    resources :survey_questions
    root "pages#dashboard"

  end

  # You can have the root of your site routed with "root"
  root "pages#home"

end
