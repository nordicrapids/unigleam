class Admin::PagesController < ApplicationController
layout "admin"
before_action :authenticate_user!
before_filter :authorize_admin

  def dashboard
    @gleams = SurveyQuestion.where('user_id = ?', current_user.id).group_by_day(:created_at, format: "%d-%m-%Y").order("day asc").count
    @users = User.all

    @gleams_by_gender = SurveyQuestion.group_by_user_gender
    @gleams_by_age = SurveyQuestion.group_by_user_age
    @gleams_by_race = SurveyQuestion.group_by_user_race
    @gleams_by_marital = SurveyQuestion.group_by_user_marital_status
    @gleams_by_state = SurveyQuestion.group_by_user_state
  end

end
