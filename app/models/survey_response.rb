# == Schema Information
#
# Table name: survey_responses
#
#  id                 :integer          not null, primary key
#  user_id            :integer
#  survey_question_id :integer
#  answer             :text
#  created_at         :datetime
#  updated_at         :datetime
#

class SurveyResponse < ActiveRecord::Base
end
