class SurveyQuestionsController < ApplicationController
before_action :authenticate_user!, only: [:create_vote_survey]

  def index
    @topic = Topic.friendly.find(params[:id])
    if params[:survey_question_id].present?
      @survey_questions = @topic.survey_questions.where(:slug => params[:survey_question_id])
    else
      @survey_questions = @topic.survey_questions
    end
  end

  def create_vote_survey

    user_survey_response = SurveyResponse.find_or_create_by({user_id: current_user.id, survey_question_id: params[:id]})
    user_survey_response.survey_question_answer_id = params[:survey_question][:answer].to_i
    user_survey_response.save

    @survey_question = SurveyQuestion.find(params[:id])
  end

  def vote_result
    @survey_question = SurveyQuestion.find(params[:id])
  end

  def vote_survey
    @survey_question = SurveyQuestion.find(params[:id])
  end

end
