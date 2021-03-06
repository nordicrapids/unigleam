Rails.application.routes.draw do

  resources :comments
  match "comments/:id/reply" => "comments#reply", :via => :post, as: "comment_reply"
  match "comment/like" => "comments#like", :via => :post, as: "comment_like"
  match "comment/dislike" => "comments#dislike", :via => :post, as: "comment_dislike"

  devise_for :users, :controllers => { :sessions => 'users/sessions', :registrations => "users/registrations", :passwords => 'users/passwords', :omniauth_callbacks => "users/omniauth_callbacks" }
    resources :users
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  match "topics" => "topics#index", :via => :get, as: "topics"
  resources :survey_questions
  # survey questions
  match "topics/:id/surveys" => "survey_questions#index", :via => :get, as: "topics_survey"
  match "topics/:id/surveys/:survey_question_id" => "survey_questions#index", :via => :get, as: "topics_survey_question"

  match "survey_question/:id/result" => "survey_questions#vote_result", :via => :get, as: "vote_result"
  match "survey_question/:id/survey" => "survey_questions#vote_survey", :via => :get, as: "vote_survey"
  match "survey_question/:id/share" => "survey_questions#share_counter", :via => :post, as: "survey_share_counter"
  match "survey_question/like" => "survey_questions#like", :via => :post, as: "survey_question_like"
  match "survey_question/dislike" => "survey_questions#dislike", :via => :post, as: "survey_question_dislike"
  match "users/:id/user_survey_question" => "survey_questions#user_survey_question", :via => :get, as: "user_survey_question"

  match "vote/:id" => "survey_questions#create_vote_survey", :via => :post, as: "create_vote_survey"
  match 'users/sessions/check_email' => "users/sessions#check_email", :via => :get
  match 'users/sessions/check_email_registration' => "users/sessions#check_email_registration", :via => :get
  match 'users/sessions/check_username' => "users/sessions#check_username", :via => :get
  match "search" => "pages#search", :via => :get, as: "search"

  match 'privacy_policy' => "topics#privacy_policy", :via => :get, as: "privacy_policy"
  match 'about' => "topics#about", :via => :get, as: "about"
  match 'how_it_works' => "topics#how_it_works", :via => :get, as: "how_it_works"
  match 'terms_of_use' => "topics#terms_of_use", :via => :get, as: "terms_of_use"
  match 'contact' => "topics#contact", :via => :get, as: "contact"
  match 'faq' => "topics#faq", :via => :get, as: "faq"

  match 'admin_pages' => "pages#admin_pages", :via => :get, as: "admin_pages"

  match 'dashboard_chart_change' => "topics#dashboard_chart_change", :via => :get, as: "dashboard_chart_change"
  match 'follow_user' => "users#follow_user", :via => :get, as: "follow_user"


  namespace :admin do
    resources :topics
    resources :survey_questions

    match "banner" => "banners#index", :via => :get, as: "banner"
    match "banner/update" => "banners#update", :via => :post, as: "update_banner"

    root "pages#dashboard"
  end

  # You can have the root of your site routed with "root"
  root "topics#index"
  get '/dashboard' => "topics#dashboard"

end
