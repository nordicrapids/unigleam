class PagesController < ApplicationController

  def search    
    @banner_image = Banner.first

    unless params[:topics].blank?
      @topics = Topic.where("name ILIKE ?", "%#{params[:topics]}%")
    end

    unless params[:gleams].blank?
      @survey_questions = SurveyQuestion.where("title ILIKE ?", "%#{params[:gleams]}%")
    end

  end 

end
