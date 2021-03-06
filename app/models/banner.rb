# == Schema Information
#
# Table name: banners
#
#  id                        :integer          not null, primary key
#  banner_image_file_name    :string
#  banner_image_content_type :string
#  banner_image_file_size    :integer
#  banner_image_updated_at   :datetime
#  banner_title              :string
#  created_at                :datetime
#  updated_at                :datetime
#

class Banner < ActiveRecord::Base

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

  def self.strong_parameters
    columns =[:id, :banner_image, :banner_title]
  end

end
