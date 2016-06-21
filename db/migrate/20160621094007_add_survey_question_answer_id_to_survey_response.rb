class AddSurveyQuestionAnswerIdToSurveyResponse < ActiveRecord::Migration
  def change
    add_reference :survey_responses, :survey_question_answer, index: true
  end
end
