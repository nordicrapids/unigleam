class TopicsController < ApplicationController

  def index
    @banner_image = Banner.first
    @topics = Topic.all
    @first_topic = @topics.first
    @other_topics = @topics.where("id != ?", @first_topic.try(:id))
  end

end
