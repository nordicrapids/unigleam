# == Schema Information
#
# Table name: survey_question_answers
#
#  id                 :integer          not null, primary key
#  survey_question_id :integer
#  answer             :string
#  position           :integer
#  created_at         :datetime
#  updated_at         :datetime
#

class SurveyQuestionAnswer < ActiveRecord::Base

  belongs_to :survey_question

  def self.strong_parameters
    columns = [:id,
              :survey_question_id,
              :answer,
              :position,
              :_destroy]
  end

end
