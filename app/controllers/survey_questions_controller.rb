class SurveyQuestionsController < ApplicationController

  def index
    @topic = Topic.friendly.find(params[:id])
    @survey_questions = @topic.survey_questions
  end

end
