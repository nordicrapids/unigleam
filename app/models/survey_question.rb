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

  belongs_to :topic

  def self.strong_parameters
    columns =[:id, :topic_id, :title, :answer_options, :share_counter]
  end

end
