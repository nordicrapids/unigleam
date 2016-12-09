class SurveyQuestionsController < ApplicationController
before_action :authenticate_user!, only: [:create_vote_survey]
layout 'user', only: [:user_survey_question, :new, :edit, :create, :update, :show]
skip_before_filter :verify_authenticity_token, only: [:create]

  def index
    if params[:id].to_i.to_s == params[:id]
      @survey_question = SurveyQuestion.find(params[:id])
      @topic = @survey_question.topic
    else
      @topic = Topic.find_by_slug(params[:id])
    end

    if params[:survey_question_id].present?
      @survey_questions = @topic.survey_questions.where(:slug => params[:survey_question_id])
    else
      if params[:id].to_i.to_s == params[:id]
        SurveyQuestionView.create(user_id: current_user.id, survey_question_id: @survey_question.id)
      else
        @survey_questions = @topic.survey_questions
      end
    end
  end

  def user_survey_question
      @survey_questions = SurveyQuestion.where('user_id = ?', params[:id])
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
    respond_to do |format|
      if (@survey_question.save)
        format.html { redirect_to user_survey_question_path(current_user.id), notice: 'Survey question has been created.' }
        format.js   {}
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @survey_question = SurveyQuestion.find_by_slug(params[:id])
    if (@survey_question.update_attributes(survey_question_params))
			flash[:notice] = "Survey question has been updated."
			redirect_to user_survey_question_path(current_user.id)
		else
			flash[:alert] = "Survey question not been updated."
			render "edit"
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

  def share_counter
    @survey_question = SurveyQuestion.friendly.find(params[:id])
    @survey_question.increment!(:share_counter)
    render json: {:status => "success"}
  end


  private
  	def survey_question_params
      columns = SurveyQuestion.strong_parameters
  		params.require(:survey_question)
  		.permit(columns)
  	end

end
