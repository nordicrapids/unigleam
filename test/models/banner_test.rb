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

require 'test_helper'

class BannerTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
