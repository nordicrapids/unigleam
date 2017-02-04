# == Schema Information
#
# Table name: topics
#
#  id                        :integer          not null, primary key
#  name                      :string
#  photo_file_name           :string
#  photo_content_type        :string
#  photo_file_size           :integer
#  photo_updated_at          :datetime
#  created_at                :datetime
#  updated_at                :datetime
#  slug                      :string
#  banner_image_file_name    :string
#  banner_image_content_type :string
#  banner_image_file_size    :integer
#  banner_image_updated_at   :datetime
#

class Topic < ActiveRecord::Base
	extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :survey_questions

  def self.strong_parameters
    columns =[:id, :name, :photo, :banner_image, :slug]
  end

	# Topic.find_each { |t| t.photo.reprocess! }

  has_attached_file :photo,
														s3_region: 'ap-northeast-1',
                            storage: :s3,
                            s3_protocol: :https,
                            s3_credentials:  "#{Rails.root}/config/amazon_s3.yml",
                            url: ':s3_domain_url',
                            path:  '/photo/:id/:filename',
                            s3_host_name: 's3-ap-northeast-1.amazonaws.com',
                            :styles => {
                              :preview => ["150x150>",:jpg],
                              :medium => ["260x260#",:jpg],
                              :large => ["100%", :jpg] },
                            :default_style => :thumb,
                            :default_url => "/assets/NoImage.gif"

  validates_attachment 	:photo,
				# :presence => true,
				:content_type => { :content_type => ["image/jpeg", "image/jpg", "image/gif", "image/png"] },
				:size => { :less_than => 5.megabyte }

  has_attached_file :banner_image,
																	s3_region: 'ap-northeast-1',
			                            storage: :s3,
			                            s3_protocol: :https,
			                            s3_credentials:  "#{Rails.root}/config/amazon_s3.yml",
			                            url: ':s3_domain_url',
			                            path:  '/banner/:id/:filename',
			                            s3_host_name: 's3-ap-northeast-1.amazonaws.com',
																	:styles => {
	                                  :preview => ["400x400",:jpg],
	                                  :large => ["100%", :jpg] },
			                            :default_style => :thumb,
			                            :default_url => "/assets/NoImage.gif"

  validates_attachment  :banner_image,
        :content_type => { :content_type => ["image/jpeg", "image/jpg", "image/gif", "image/png"] }

  def visible_survey_questions current_user
    SurveyQuestion.visible(current_user).where(topic_id: id)
  end
end
