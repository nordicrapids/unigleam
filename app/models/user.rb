# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime
#  updated_at             :datetime
#  provider               :string
#  uid                    :string
#  is_admin               :boolean          default(FALSE)
#  first_name             :string
#  last_name              :string
#  age                    :integer
#  address                :text
#  latitude               :float
#  longitude              :float
#

class User < ActiveRecord::Base
  geocoded_by :address
  after_validation :geocode

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]

  has_many :survey_responses
  has_many :survey_questions
=begin
  has_attached_file :profile_image,
                            s3_region: 'us-west-2',
                            storage: :s3,
                            s3_protocol: :https,
                            s3_credentials:  "#{Rails.root}/config/amazon_s3.yml",
                            url: ':s3_domain_url',
                            path:  '/profile_image/:id/:filename',
                            s3_host_alias: 'https://s3-us-west-2.amazonaws.com/',
                            :styles => {
                              :preview => ["150x150>",:jpg],
  														:medium => ["260x260#",:jpg],
  														:large => ["100%", :jpg] },
														:default_style => :thumb,
														:default_url => "/assets/NoImage.gif"

=end

has_attached_file :profile_image,
                  :styles => { :myrecipes => "260x180#", :showrecipe => "600x300#", :medium => "300x300>", :thumb => "100x100>" },
                  :storage => :s3,
                  s3_region: 'us-west-2',
                  :s3_credentials => "#{Rails.root}/config/amazon_s3.yml",
                  :path => "/images/:id/:style.:extension",
                  :url => ":s3_domain_url"

  # has_attached_file :profile_image,
  #     s3_region: 'us-west-2',
  #     storage: :s3,
  #     s3_protocol: :https,
  #     s3_credentials:  "#{Rails.root}/config/amazon_s3.yml",
  #     s3_host_name: "s3-us-west-2.amazonaws.com",
  #     url: ':s3_domain_url',
  #     path:  '/images/:id/:filename'

  validates_attachment 	:profile_image,
				:presence => true,
				:content_type => { :content_type => ["image/jpeg", "image/jpg", "image/gif", "image/png"] },
				:size => { :less_than => 5.megabyte }

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email

      if auth.info.name.present?
        name = auth.info.name.split(' ', 2)
        user.first_name = name.first
        user.last_name  = name.last
      end

      user.password = Devise.friendly_token[0,20]
    end
  end

  def full_name
    user = self
    name = "#{user.first_name} #{user.last_name}"
    return name
  end

end
