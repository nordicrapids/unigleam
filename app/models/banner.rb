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

  has_attached_file :banner_image,:styles => {
                                  :preview => ["400x400",:jpg],
                                  :large => ["100%", :jpg] },
                                  :default_url => "/assets/missing.png",
                                  :storage => :s3,
                                  :s3_credentials => {:access_key_id => ENV['AWS_ACCESS_KEY_ID'],
                                                      :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY'],
                                                      :bucket => ENV['AWS_BUCKET'],
                                                      }

  validates_attachment  :banner_image,
        :content_type => { :content_type => ["image/jpeg", "image/jpg", "image/gif", "image/png"] }

  def self.strong_parameters
    columns =[:id, :banner_image, :banner_title]
  end

end
