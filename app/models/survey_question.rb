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
  has_many :survey_question_answers, -> { order(position: :asc) }
  has_many :survey_responses

  accepts_nested_attributes_for :survey_question_answers, :allow_destroy => true

  def self.strong_parameters
    columns =[:id, :topic_id, :title, :answer_options, :share_counter, :survey_question_answers_attributes => [SurveyQuestionAnswer.strong_parameters]]
  end

end
