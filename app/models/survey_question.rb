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
  acts_as_votable
  acts_as_commentable
  extend FriendlyId
  friendly_id :title, use: :slugged
  belongs_to :user
  belongs_to :topic
  has_many :survey_question_answers, -> { order(position: :asc) }
  accepts_nested_attributes_for :survey_question_answers, :allow_destroy => true
  has_many :survey_responses
  has_many :comments
  accepts_nested_attributes_for :comments, :allow_destroy => true
  has_many :survey_question_views

  has_attached_file :image,

                            s3_region: 'ap-northeast-1',
                            storage: :s3,
                            s3_protocol: :https,
                            s3_credentials:  "#{Rails.root}/config/amazon_s3.yml",
                            url: ':s3_domain_url',
                            path:  '/images/:id/:filename',
                            s3_host_name: 's3-ap-northeast-1.amazonaws.com',
                            :styles => {
                              :preview => ["150x150>",:jpg],
                              :medium => ["260x260#",:jpg],
                              :large => ["100%", :jpg] },
                            :default_style => :thumb,
                            :default_url => "/assets/NoImage.gif"

  validates_attachment 	:image,
				# :presence => true,
				:content_type => { :content_type => ["image/jpeg", "image/jpg", "image/gif", "image/png"] },
				:size => { :less_than => 5.megabyte }

  has_attached_file :video,
                    s3_region: 'ap-northeast-1',
                    storage: :s3,
                    s3_protocol: :https,
                    s3_credentials:  "#{Rails.root}/config/amazon_s3.yml",
                    url: ':s3_domain_url',
                    path:  '/videos/:id/:filename',
                    s3_host_name: 's3-ap-northeast-1.amazonaws.com',
                    :styles => {
                      :thumb => { :geometry => "100x100#", :format => 'jpg', :time => 10 }
                    },
                    processors: [:ffmpeg]

  STATUSES = ['public', 'private']
  validates_inclusion_of :status, :in => STATUSES, :message => "{{value}} must be in #{STATUSES.join ','}"

  def self.strong_parameters
    columns =[:id, :topic_id, :title, :answer_options, :share_counter, :image, :status, :user_id, :video, :synopsis, :survey_question_answers_attributes => [SurveyQuestionAnswer.strong_parameters]]
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

  # if you are logged in, you can see gleams you created, or voted or liked or are public
  # if you are not logged in, you can see gleams are public
  def self.visible current_user
    if current_user
      vote_survey_ids = SurveyResponse.where(user_id: current_user.id).pluck(:survey_question_id)

      like_survey_ids = current_user.get_voted(SurveyQuestion).pluck(:id)

      current_user.get_voted(Comment).each do |comment|
        like_survey_ids << comment.commentable(SurveyQuestion).id
      end

      survey_ids = (vote_survey_ids + like_survey_ids).uniq
      
      where("survey_questions.status = ? OR survey_questions.user_id = ? OR survey_questions.id in (?)", "public", current_user.id, survey_ids )
    else
      where(status: "public")
    end
  end

  def self.group_by_user_gender
    joins("left join users on survey_questions.user_id = users.id").group("users.gender").count
  end

  def self.group_by_user_race
    joins("left join users on survey_questions.user_id = users.id").group("users.race").count
  end

  def self.group_by_user_marital_status
    joins("left join users on survey_questions.user_id = users.id").group("users.marital_status").count
  end

  def self.group_by_user_age
    joins("left join users on survey_questions.user_id = users.id").group("users.age").count
  end

  def self.group_by_user_state
    joins("left join users on survey_questions.user_id = users.id").group("users.state").count
  end

end
