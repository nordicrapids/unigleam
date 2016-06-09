# == Schema Information
#
# Table name: topics
#
#  id                 :integer          not null, primary key
#  name               :string
#  photo_file_name    :string
#  photo_content_type :string
#  photo_file_size    :integer
#  photo_updated_at   :datetime
#  created_at         :datetime
#  updated_at         :datetime
#  slug               :string
#

class Topic < ActiveRecord::Base
	extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :survey_questions

  def self.strong_parameters
    columns =[:id, :name, :photo, :slug]
  end

  has_attached_file :photo, :styles => {
                            :preview => ["150x150>",:jpg],
														:large => ["100%", :jpg] },
														:default_style => :thumb,
														:default_url => "/assets/missing.png",
														:storage => :s3,
														:s3_credentials => {:access_key_id => ENV['AWS_ACCESS_KEY_ID'],
																								:secret_access_key => ENV['AWS_SECRET_ACCESS_KEY'],
                                                :bucket => ENV['AWS_BUCKET'],
																								}
  validates_attachment 	:photo,
				:presence => true,
				:content_type => { :content_type => ["image/jpeg", "image/jpg", "image/gif", "image/png"] },
				:size => { :less_than => 5.megabyte }


end
