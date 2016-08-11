class PagesController < ApplicationController

  def search    
    @banner_image = Banner.first

    @topics = Topic.where("name ILIKE ?", "%#{params[:topics]}%")
    @survey_questions = SurveyQuestion.where("title ILIKE ?", "%#{params[:gleams]}%")

  end 

end
