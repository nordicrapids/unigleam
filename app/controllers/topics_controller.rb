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
    @survey_responses = SurveyResponse.group_by_day(:created_at, format: "%Y-%m-%d").order("day asc").count
    @users = User.all
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
