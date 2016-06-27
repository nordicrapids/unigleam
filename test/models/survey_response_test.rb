# == Schema Information
#
# Table name: survey_responses
#
#  id                        :integer          not null, primary key
#  user_id                   :integer
#  survey_question_id        :integer
#  answer                    :text
#  created_at                :datetime
#  updated_at                :datetime
#  survey_question_answer_id :integer
#

require 'test_helper'

class SurveyResponseTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
