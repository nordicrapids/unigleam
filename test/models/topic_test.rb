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

require 'test_helper'

class TopicTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
