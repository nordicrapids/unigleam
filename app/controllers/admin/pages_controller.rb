class Admin::PagesController < ApplicationController
layout "admin"
before_action :authenticate_user!
before_filter :authorize_admin

  def dashboard
    @survey_responses = SurveyResponse.group_by_day(:created_at, format: "%Y-%m-%d").order("day asc").count
    @users = User.all
  end

end
