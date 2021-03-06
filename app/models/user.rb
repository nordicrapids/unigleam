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
#  gender                 :string
#  birthday               :datetime
#  race                   :string
#  maritial_status        :string
#  maritial_status        :string
#  city                   :string
#  zip                    :string
#

class User < ActiveRecord::Base
  acts_as_voter
  # extending the omniauth lib
  extend OmniauthUnigleam

  geocoded_by :address
  after_validation :geocode
  attr_accessor :login
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]

  has_many :survey_question_views
  has_many :survey_responses
  has_many :survey_questions
  has_many :comments
  accepts_nested_attributes_for :comments, :allow_destroy => true

  has_many :authenticates, dependent: :destroy

  has_many :user_follows, foreign_key: "user_id"

  before_destroy :remove_user_follows

  has_attached_file :profile_image,
                                s3_region: 'ap-northeast-1',
                                storage: :s3,
                                s3_protocol: :https,
                                s3_credentials:  "#{Rails.root}/config/amazon_s3.yml",
                                url: ':s3_domain_url',
                                path:  '/profile_image/:id/:filename',
                                s3_host_name: 's3-ap-northeast-1.amazonaws.com',
                                :styles => {
                                  :preview => ["150x150>",:jpg],
                                  :medium => ["260x260#",:jpg],
                                  :large => ["100%", :jpg] },
                                :default_style => :thumb,
                                :default_url => "/assets/NoImage.gif"

  validates_attachment 	:profile_image,
				# :presence => true,
				:content_type => { :content_type => ["image/jpeg", "image/jpg", "image/gif", "image/png"] },
				:size => { :less_than => 5.megabyte }

  def self.from_omniauth(ominiauth_data)
    user = my_omniauth(ominiauth_data)
  end

  def full_name
    user = self
    name = "#{user.first_name} #{user.last_name}"
    return name
  end

  def login=(login)
    @login = login
  end

  def login
    @login || self.username || self.email
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end

  def remove_user_follows
    user = self
    UserFollow.where('user_id = ? or follow_id = ?', user.id,user.id).delete_all
  end

end
