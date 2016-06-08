class Admin::SurveyQuestionsController < ApplicationController
  layout "admin"

  def index
    @survey_questions = SurveyQuestion.all
  end

  def new
    @survey_question = SurveyQuestion.new
  end

  def edit
    @survey_question = SurveyQuestion.find(params[:id])
  end

  def show
    @survey_question = SurveyQuestion.find(params[:id])
  end

  def create
    @survey_question = SurveyQuestion.new(survey_question_params)
    if (@survey_question.save)
			flash[:notice] = "Survey question has been created."
			redirect_to admin_survey_questions_path
		else
			flash[:alert] = "Survey question has not been created."
			render "new"
		end
  end

  def update
    @survey_question = SurveyQuestion.find(params[:id])
    if (@survey_question.update_attributes(survey_question_params))
			flash[:notice] = "Survey question has been updated."
			redirect_to admin_survey_questions_path
		else
			flash[:alert] = "Survey question not been updated."
			render "edit"
		end
  end

private
  	def survey_question_params
      columns = SurveyQuestion.strong_parameters
  		params.require(:survey_question)
  		.permit(columns)
  	end

end
