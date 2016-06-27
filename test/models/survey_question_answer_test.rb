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

require 'test_helper'

class SurveyQuestionAnswerTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
