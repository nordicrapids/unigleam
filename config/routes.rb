Rails.application.routes.draw do

  devise_for :users, :controllers => { :sessions => 'users/sessions', :registrations => "users/registrations", :omniauth_callbacks => "users/omniauth_callbacks" }

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  match "topics" => "topics#index", :via => :get, as: "topics"

  # survey questions
  match "topics/:id/surveys" => "survey_questions#index", :via => :get, as: "topics_survey"

  match "survey_question/:id/result" => "survey_questions#vote_result", :via => :get, as: "vote_result"
  match "survey_question/:id/survey" => "survey_questions#vote_survey", :via => :get, as: "vote_survey"

  match "vote/:id" => "survey_questions#create_vote_survey", :via => :post, as: "create_vote_survey"

  namespace :admin do
    resources :topics
    resources :survey_questions
    root "pages#dashboard"
  end

  # You can have the root of your site routed with "root"
  root "topics#index"

end
