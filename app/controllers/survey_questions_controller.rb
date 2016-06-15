class SurveyQuestionsController < ApplicationController
before_action :authenticate_user!, only: [:create_vote_survey]

  def index
    @topic = Topic.friendly.find(params[:id])
    @survey_questions = @topic.survey_questions
  end

  def create_vote_survey
    current_user.survey_responses.create(:survey_question_id => params[:id], :answer => params[:survey_question][:answer])
    @survey_question = SurveyQuestion.find(params[:id])
  end

  def vote_result
    @survey_question = SurveyQuestion.find(params[:id])
  end

  def vote_survey
    @survey_question = SurveyQuestion.find(params[:id])
  end

end
