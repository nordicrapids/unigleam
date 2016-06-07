# == Schema Information
#
# Table name: survey_questions
#
#  id             :integer          not null, primary key
#  topic_id       :integer
#  title          :string
#  answer_options :text
#  share_counter  :integer
#  created_at     :datetime
#  updated_at     :datetime
#

class SurveyQuestion < ActiveRecord::Base
end
