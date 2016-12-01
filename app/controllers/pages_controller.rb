class PagesController < ApplicationController
  layout 'admin', only: [:admin_pages]
  def search
    @banner_image = Banner.first

    unless params[:topics].blank?
      @topics = Topic.where("name ILIKE ?", "%#{params[:topics]}%")
    end

    unless params[:gleams].blank?
      @survey_questions = SurveyQuestion.where("title ILIKE ?", "%#{params[:gleams]}%")
    end

    unless params[:profiles].blank?
      @profiles = User.where("email ILIKE ?", "%#{params[:profiles]}%")
    end

  end

  def admin_pages
  end

end
