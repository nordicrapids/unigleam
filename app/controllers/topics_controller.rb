class TopicsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  layout "user", only: [:dashboard]
  def index
    @banner_image = Banner.first
    @topics = Topic.all
    @first_topic = @topics.first
    @other_topics = @topics.where("id != ?", @first_topic.try(:id))
  end

  def dashboard
    # @survey_responses = SurveyResponse.group_by_day(:created_at, format: "%d-%m-%Y").order("day asc").count
     @gleams = SurveyQuestion.where('user_id = ? and created_at >= ?', current_user.id, 30.days.ago).group_by_day(:created_at, format: "%d-%m-%Y").order("day asc").count
    # %Y-%m-%d
    @users = User.all

    @gleams_by_gender = SurveyQuestion.visible(current_user).group_by_user_gender
    @gleams_by_age = SurveyQuestion.visible(current_user).group_by_user_age
  end

  def dashboard_chart_change
    if params[:for].present?
      if params[:for] == "view_of_gleams"
        @users = SurveyQuestionView.where('survey_question_id IN (?)', current_user.survey_question_ids).group_by_day(:created_at, format: "%d-%m-%Y").order("day asc").count
      elsif params[:for] == "no_of_followers"
        @followers = UserFollow.where('user_id = ?', current_user.id)
        @followers_count = @followers.group_by_day(:created_at, format: "%d-%m-%Y").order("day asc").count
      elsif params[:for] == "no_of_followings"
        @followings = UserFollow.where('follow_id = ?', current_user.id)
        @followings_count = @followings.group_by_day(:created_at, format: "%d-%m-%Y").order("day asc").count
      elsif params[:for] == "no_of_casted"
        @gleams = SurveyQuestion.where('user_id = ?', current_user.id).group_by_day(:created_at, format: "%d-%m-%Y").order("day asc").count
      elsif params[:for] == "no_of_shared"
        @survey_responses = SurveyQuestion.group_by_day(:created_at, format: "%d-%m-%Y").order("day asc").count
      end
    end
  end

  def privacy_policy
    render :layout => false
  end

  def about
    render :layout => false
  end

  def how_it_works
    render :layout => false
  end

  def terms_of_use
    render :layout => false
  end

  def contact
    render :layout => false
  end

  def faq
    render :layout => false
  end
end
