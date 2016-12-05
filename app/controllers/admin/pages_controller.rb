class Admin::PagesController < ApplicationController
layout "admin"
before_action :authenticate_user!
before_filter :authorize_admin

  def dashboard
    @gleams = SurveyQuestion.where('user_id = ?', current_user.id).group_by_day(:created_at, format: "%d-%m-%Y").order("day asc").count
    @users = User.all
  end

end
