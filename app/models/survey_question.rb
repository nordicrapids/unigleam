# == Schema Information
#
# Table name: survey_questions
#
#  id                 :integer          not null, primary key
#  topic_id           :integer
#  title              :string
#  answer_options     :text
#  share_counter      :integer
#  created_at         :datetime
#  updated_at         :datetime
#  image_file_name    :string
#  image_content_type :string
#  image_file_size    :integer
#  image_updated_at   :datetime
#  slug               :string
#

class SurveyQuestion < ActiveRecord::Base

  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :topic
  has_many :survey_question_answers, -> { order(position: :asc) }
  has_many :survey_responses

  accepts_nested_attributes_for :survey_question_answers, :allow_destroy => true

  has_attached_file :image, :styles => {
                            :preview => ["150x150>",:jpg],
														:medium => ["260x260#",:jpg],
														:large => ["100%", :medium] },
														:default_style => :thumb,
														:default_url => "/assets/missing.png",
														:storage => :s3,
														:s3_credentials => {:access_key_id => ENV['AWS_ACCESS_KEY_ID'],
																								:secret_access_key => ENV['AWS_SECRET_ACCESS_KEY'],
                                                :bucket => ENV['AWS_BUCKET'],
																								}
  validates_attachment 	:image,
				:presence => true,
				:content_type => { :content_type => ["image/jpeg", "image/jpg", "image/gif", "image/png"] },
				:size => { :less_than => 5.megabyte }


  def self.strong_parameters
    columns =[:id, :topic_id, :title, :answer_options, :share_counter, :image, :survey_question_answers_attributes => [SurveyQuestionAnswer.strong_parameters]]
  end

  def user_response(user)
    survey_question = self
    survey_response = SurveyResponse.where({user_id: user.id, survey_question_id: survey_question.id}).first

    if survey_response.present?
      return survey_response.survey_question_answer_id
    else
      return ""
    end
  end

end