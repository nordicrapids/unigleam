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
#

class Topic < ActiveRecord::Base
end
