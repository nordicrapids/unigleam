class SurveyQuestionView < ActiveRecord::Base
  belongs_to :user
  belongs_to :survey_question
end
