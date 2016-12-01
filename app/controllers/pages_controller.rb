class PagesController < ApplicationController
  layout 'admin', only: [:admin_pages]
  def search
    @banner_image = Banner.first

    unless params[:topics].blank?
      @topics = Topic.where("name ILIKE ?", "%#{params[:topics]}%")
    end

    unless params[:gleams].blank?
      @survey_questions = SurveyQuestion.where("title ILIKE ?", "%#{params[:gleams]}%")
      @profiles = User.where("email ILIKE ?", "%#{params[:gleams]}%")
    end

    unless params[:profiles].blank?
      @profiles = User.where("email ILIKE ?", "%#{params[:profiles]}%")
    end
    # respond_to do |format|
    #   format.html { }
    #   format.json { render json: @survey_questions.map(&:title), status_code: 200, success: true }
    # end
  end

  def admin_pages
  end

  def admin_pages
  end

end
